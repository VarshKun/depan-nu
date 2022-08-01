// ignore_for_file: unnecessary_string_interpolations
// ignore: depend_on_referenced_packages
import 'package:alan_voice/alan_voice.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depan_nu/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:local_auth/local_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'globalvariables.dart' as globals;

class PaymentsPage extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _PaymentsPageState? instance;
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  _PaymentsPageState() {
    PaymentsPage.instance = this;
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  // ignore: unused_field
  bool _canCheckBiometric = false;
  // ignore: unused_field
  bool _isBiometricSupported = false;
  DatabaseReference workersDB = FirebaseDatabase.instance.ref('workers');
  DatabaseReference bookingDB = FirebaseDatabase.instance.ref('bookings');
  final user = FirebaseAuth.instance.currentUser!;
  String _authorizedOrNot = "Not authorized";
  // ignore: unused_field
  List<BiometricType> _availableBiometricTypes = <BiometricType>[];
  int bookingCounter = 1;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    bool isBiometricSupported = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
      isBiometricSupported = await _localAuthentication.isDeviceSupported();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _canCheckBiometric = canCheckBiometric;
      _isBiometricSupported = isBiometricSupported;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometric = [];
    try {
      listOfBiometric = await _localAuthentication.getAvailableBiometrics();
      // ignore: avoid_print
      print('LIST: ${listOfBiometric.toString()}');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _availableBiometricTypes = listOfBiometric;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticate(
        localizedReason: "Please authenticate to complete your transaction",
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
              signInTitle: '****** Biometric authentication required! ******',
              biometricHint: 'Verify fingerprint',
              cancelButton: 'CANCEL',
              biometricSuccess: 'Authentication successful!'),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
      if (e.code == auth_error.notEnrolled) {}
    }

    if (!mounted) {
      return;
    }
    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "authorized";
      } else {
        _authorizedOrNot = "Not authorized";
      }
    });
  }

  void confirmPayment() async {
    if (formKey.currentState!.validate()) {
      AlanVoice.playText('Please scan your finger to confirm payment');
      _checkBiometric();
      _getListOfBiometricTypes();
      await _authorizeNow();
      if (_authorizedOrNot == "authorized") {
        await workersDB
            .child('worker${globals.closestWorkerID}')
            .update({'serving': '${user.email}'});

        DatabaseReference newBooking = bookingDB.push();
        String formattedDate =
            DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
        if (globals.categorySelected == "AC") {
          FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'bookings': FieldValue.arrayUnion([
              {
                "booking id": '$bookingCounter',
                "date": '$formattedDate',
                "total cost": '${globals.totalCost}',
                "customer email": '${user.email}',
                "served by": '${globals.closestWorkerName}',
                // ignore: unnecessary_null_comparison,
                "service": '${globals.acService}',
                "type of property": '${globals.propertyType}',
                "no of units": '${globals.noOfUnits}',
                "no of rooms": '${globals.noOfRooms}',
              }
            ])
          });
          await newBooking.set({
            "booking id": bookingCounter,
            "date": formattedDate,
            "total cost": globals.totalCost,
            "customer email": user.email,
            "served by": globals.closestWorkerName,
            // ignore: unnecessary_null_comparison
            "service": globals.acService,
            "type of property": globals.propertyType,
            "no of units": globals.noOfUnits,
            "no of rooms": globals.noOfRooms,
          });
        } else if (globals.categorySelected == "Salon") {
          FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'bookings': FieldValue.arrayUnion([
              {
                "booking id": '$bookingCounter',
                "date": '$formattedDate',
                "total cost": '${globals.totalCost}',
                "customer email": '${user.email}',
                "served by": '${globals.closestWorkerName}',
                // ignore: unnecessary_null_comparison,
                "service": '${globals.salonService}',
                "occasion type": '${globals.occasionType}',
                "no of persons": '${globals.noOfPersons}',
              }
            ])
          });
          await newBooking.set({
            "booking id": bookingCounter,
            "date": formattedDate,
            "total cost": globals.totalCost,
            "customer email": user.email,
            "served by": globals.closestWorkerName,
            // ignore: unnecessary_null_comparison
            "service": globals.salonService,
            "occasion type": globals.occasionType,
            "no of persons": globals.noOfPersons,
          });
        }

        bookingCounter++;

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
        AlanVoice.playText("Booking complete");
      } else {
        AlanVoice.playText("Invalid fingerprint. Please re-scan your finger");
      }
    } else {
      AlanVoice.playText("Invalid card. Please enter correct card details");
    }
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff020435).withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F5F9),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                //glassmorphismConfig: useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: false,
                obscureCardCvv: false,
                isHolderNameVisible: true,
                //cardBgColor: Colors.red,
                backgroundImage: 'assets/images/card_bg.png',
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: false,
                        obscureNumber: false,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: const Color(0xff020435),
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Color(0xff020435)),
                          labelStyle: const TextStyle(color: Color(0xff020435)),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xff020435)),
                          labelStyle: const TextStyle(color: Color(0xff020435)),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expiry Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xff020435)),
                          labelStyle: const TextStyle(color: Color(0xff020435)),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xff020435)),
                          labelStyle: const TextStyle(color: Color(0xff020435)),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: const Color(0xff3C42E0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text(
                            'Confirm payment',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: () async {
                          confirmPayment();
                          AlanVoice.playText("Booking complete");
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
