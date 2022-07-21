import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depan_nu/all_categories.dart';
import 'package:depan_nu/subcategories/ac_repair.dart';
import 'package:depan_nu/subcategories/appliance_repair.dart';
import 'package:depan_nu/subcategories/cleaning.dart';
import 'package:depan_nu/subcategories/electrical.dart';
import 'package:depan_nu/subcategories/flooring.dart';
import 'package:depan_nu/subcategories/painting.dart';
import 'package:depan_nu/subcategories/plumbing.dart';
import 'package:depan_nu/subcategories/salon.dart';
import 'package:depan_nu/subcategories/shifting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'auth/fb_sign_in.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class CardItem {
  final String urlImage;
  final String title;

  const CardItem({required this.urlImage, required this.title});
}

class _HomeScreenState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  var accessToken = FbSignInProvider.fbLoginDetails.accessToken?.token;
  int currentIndex = 0;
  String text = 'Choose the service you need';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String imageUrl = "";
  bool isLoading = true;
  late TextEditingController controller;
  final FlutterTts flutterTts = FlutterTts();

  List<String> autoCompleteData = [
    "AC Repair",
    "Appliance repair",
    "Cleaning",
    "Electrical",
    "Flooring",
    "Painting",
    "Plumbing",
    "Salon",
    "Shifting",
  ];

  Future speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    await flutterTts.setSpeechRate(0.5);
  }

  void _getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // ignore: avoid_print
        print('Document data: ${documentSnapshot.data()}');
        setState(() {
          imageUrl = (documentSnapshot.data() as Map)['profile picture'];
          isLoading = false;
        });
      } else {
        // ignore: avoid_print
        print('Document doesnt exist');
      }
    });
  }

  List<CardItem> items = [
    const CardItem(
      urlImage: 'assets/images/Promo/HomeCleaning.png',
      title: 'Home Cleaning',
    ),
    const CardItem(
      urlImage: 'assets/images/Promo/CarpetCleaning.jpg',
      title: 'Carpet Cleaning',
    ),
    const CardItem(
      urlImage: 'assets/images/Promo/SofaCleaning.jpg',
      title: 'Sofa Cleaning',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    if (user.photoURL == null) {
      _getData();
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //return WillPopScope(
    //onWillPop: () async => false,
    return isLoading
        ? Container(
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff020435),
                color: Colors.amber,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFFF1F5F9),
            body: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          //choose services section
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        //child: Container(color: Colors.red),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.black,
                                                  ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: user.photoURL ==
                                                                  null
                                                              ? CircleAvatar(
                                                                  radius: 40,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          imageUrl),
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 40,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    accessToken ==
                                                                            null
                                                                        ? user
                                                                            .photoURL!
                                                                        : "${user.photoURL!}?height=1000&access_token=$accessToken",
                                                                  ),
                                                                ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              const Text(
                                                                "Welcome back 👋",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff020435),
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                              ),
                                                              user.displayName ==
                                                                      null
                                                                  ? const Text(
                                                                      "Username not found",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff020435),
                                                                        fontSize:
                                                                            24,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      user.displayName!,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Color(
                                                                            0xff020435),
                                                                        fontSize:
                                                                            24,
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        // child: Container(
                                        //   color: Colors.amber,
                                        // ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.white,
                                                  ),
                                            ),
                                            const Expanded(
                                              flex: 12,
                                              child: Text(
                                                "What are you looking for today?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xff020435),
                                                  fontSize: 32,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        // child: Container(
                                        //   color: Colors.red,
                                        // ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.red,
                                                  ),
                                            ),
                                            Expanded(
                                              flex: 20,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Autocomplete(
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingvalue) {
                                                    if (textEditingvalue
                                                        .text.isEmpty) {
                                                      return const Iterable<
                                                          String>.empty();
                                                    } else {
                                                      return autoCompleteData
                                                          .where(
                                                        (word) => word
                                                            .toLowerCase()
                                                            .contains(
                                                                textEditingvalue
                                                                    .text
                                                                    .toLowerCase()),
                                                      );
                                                    }
                                                  },
                                                  optionsViewBuilder: (
                                                    context,
                                                    Function(String) onSelected,
                                                    options,
                                                  ) {
                                                    return Material(
                                                      elevation: 4,
                                                      child: ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final option = options
                                                              .elementAt(index);
                                                          return ListTile(
                                                            title:
                                                                SubstringHighlight(
                                                              text: option
                                                                  .toString(),
                                                              term: controller
                                                                  .text,
                                                              textStyleHighlight:
                                                                  const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            ),
                                                            onTap: () {
                                                              onSelected(option
                                                                  .toString());
                                                            },
                                                          );
                                                        },
                                                        itemCount:
                                                            options.length,
                                                        separatorBuilder:
                                                            (BuildContext
                                                                        context,
                                                                    int index) =>
                                                                const Divider(),
                                                      ),
                                                    );
                                                  },
                                                  onSelected: (selectedString) {
                                                    //print(selectedString);
                                                    if (selectedString ==
                                                        "AC Repair") {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AcRepairPage(),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  fieldViewBuilder: (
                                                    context,
                                                    controller,
                                                    focusNode,
                                                    onEditingComplete,
                                                  ) {
                                                    this.controller =
                                                        controller;
                                                    return CupertinoSearchTextField(
                                                      onSubmitted: (value) {
                                                        if (value ==
                                                                "AC Repair" ||
                                                            value.toLowerCase() ==
                                                                "ac repair") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AcRepairPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Salon" ||
                                                            value.toLowerCase() ==
                                                                "salon") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const SalonPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Appliance Repair" ||
                                                            value.toLowerCase() ==
                                                                "appliance repair") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ApplianceRepairPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Painting" ||
                                                            value.toLowerCase() ==
                                                                "painting") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PaintingPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Cleaning" ||
                                                            value.toLowerCase() ==
                                                                "cleaning") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const CleaningPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Plumbing" ||
                                                            value.toLowerCase() ==
                                                                "plumbing") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PlumbingPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Electrical" ||
                                                            value.toLowerCase() ==
                                                                "electrical") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ElectricalPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Shifting" ||
                                                            value.toLowerCase() ==
                                                                "shifting") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ShiftingPage(),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                                "Flooring" ||
                                                            value.toLowerCase() ==
                                                                "flooring") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const FlooringPage(),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      controller: controller,
                                                      focusNode: focusNode,
                                                      backgroundColor:
                                                          Colors.white,
                                                      //backgroundColor: Color(0xfffbfbfb),
                                                      placeholder: text,
                                                      placeholderStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xff9b9e9f),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      //itemSize: 50,
                                                      //itemColor: Color(0xff3C42E0),
                                                      prefixIcon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xff9b9e9f),
                                                        size: 30,
                                                      ),
                                                      suffixMode:
                                                          OverlayVisibilityMode
                                                              .notEditing,
                                                      suffixIcon: Icon(
                                                        _isListening
                                                            ? Icons.mic
                                                            : Icons.mic_none,
                                                        color: const Color(
                                                            0xff4EFF3F),
                                                        size: 30,
                                                      ),
                                                      onSuffixTap: _listen,
                                                    );
                                                  },
                                                  //child:
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  //color: Colors.red,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        //child: Container(color: Colors.amber),
                                        child: Container(
                                          //color: Colors.amber,
                                          constraints: const BoxConstraints(
                                            maxWidth: 340,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            //color: const Color(0xfffbfbfb),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AcRepairPage(),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffffcbb0),
                                                        fixedSize: const Size(
                                                            200, 100),
                                                        shape:
                                                            const CircleBorder(),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/icons/ACRepair.png",
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "AC Repair",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xcc010435),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const SalonPage(),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffD7CDFF),
                                                        fixedSize: const Size(
                                                            200, 100),
                                                        shape:
                                                            const CircleBorder(),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/icons/Salon.png",
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Salon",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xcc010435),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ApplianceRepairPage(),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffC1ECFF),
                                                        fixedSize: const Size(
                                                            200, 100),
                                                        shape:
                                                            const CircleBorder(),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/icons/Appliance.png",
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Appliance Repair",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xcc010435),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CategoriesPage(),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffFAFAFA),
                                                        fixedSize: const Size(
                                                            200, 100),
                                                        shape:
                                                            const CircleBorder(),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/icons/SeeAll.png",
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "See All",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xcc010435),
                                                        fontSize: 15,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //start of promo section
                          Expanded(
                            flex: 2,
                            //child: Container(color: Colors.green),
                            child: Column(
                              children: [
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 340,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      //color: const Color(0xfffbfbfb),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Image.asset(
                                                          "assets/images/icons/tag.png"),
                                                    ),
                                                    const Expanded(
                                                      child: SizedBox(
                                                        child: Text(
                                                          "Cleaning Services",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff172b4d),
                                                            fontSize: 18,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                height: 45,
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 25,
                                                      ),
                                                      const Text(
                                                        "See All",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff6f767d),
                                                          fontSize: 14,
                                                          fontFamily: "Lato",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/icons/Next.png",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            height: 100,
                                            child: ListView.separated(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 3,
                                              separatorBuilder: (context, _) =>
                                                  const SizedBox(width: 12),
                                              itemBuilder: (context, index) =>
                                                  buildcard(item: items[index]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 340,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x3f000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      child: ListView(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 6,
                                          bottom: 6,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Offer AC Service",
                                                style: TextStyle(
                                                  color: Color(0xff020435),
                                                  fontSize: 13,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const SizedBox(
                                                width: 241,
                                                child: Text(
                                                  "Get 25%",
                                                  style: TextStyle(
                                                    color: Color(0xff020435),
                                                    fontSize: 48,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              //const SizedBox(height: 5),
                                              TextButton(
                                                onPressed: () {},
                                                child: Container(
                                                  width: 90,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.white,
                                                  ),
                                                  //padding: const EdgeInsets.all(3),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "Grab Offer",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff6a9b7e),
                                                          fontSize: 14,
                                                          fontFamily: "Lato",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/icons/NextGreen.png",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 289,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: const Color(0xffffbc99),
                                            ),
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        "Offer",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff020435),
                                                          fontSize: 13,
                                                          fontFamily: "Lato",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    const SizedBox(
                                                      width: 241,
                                                      child: Text(
                                                        "Get 15%",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff020435),
                                                          fontSize: 48,
                                                          fontFamily: "Lato",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Container(
                                                        width: 90,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              "Grab Offer",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff83C1DE),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Container(
                                                              width: 10,
                                                              height: 10,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/icons/NextBlue.png",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    constraints: const BoxConstraints(
                                      maxWidth: 340,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      //color: const Color(0xfffbfbfb),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Image.asset(
                                                    "assets/images/icons/tagPurple.png"),
                                              ),
                                              const Expanded(
                                                child: SizedBox(
                                                  child: Text(
                                                    "Appliance repair",
                                                    style: TextStyle(
                                                      color: Color(0xff172b4d),
                                                      fontSize: 18,
                                                      fontFamily: "Lato",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            width: 309,
                                            height: 206,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: 309,
                                                  height: 206,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 309,
                                                        height: 206,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: const Color(
                                                              0xffeceaf6),
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: SizedBox(
                                                            width: 125,
                                                            height: 212,
                                                            child: Image.asset(
                                                                "assets/images/Promo/Appliance.png"),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 16,
                                                  top: 44,
                                                  child: SizedBox(
                                                    width: 267,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                "Offer Dry Cleaning",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff020435),
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            const SizedBox(
                                                              width: 241,
                                                              child: Text(
                                                                "Get 25%",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff020435),
                                                                  fontSize: 48,
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            TextButton(
                                                              onPressed: () {},
                                                              child: Container(
                                                                width: 90,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Text(
                                                                      "Grab Offer",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xffCABDFF),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "Lato",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Container(
                                                                      width: 10,
                                                                      height:
                                                                          10,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/icons/NextPurple.png",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
    //);
  }

  Future<void> _listen() async {
    final player = AudioPlayer();
    if (!_isListening) {
      bool available = await _speech.initialize(
        // ignore: avoid_print
        onStatus: (val) => {
          // ignore: avoid_print
          print('onStatus: $val'),
          if (val == "done" || val == "notListening")
            {
              setState(
                () => _isListening = false,
              ),
              player.play(AssetSource('sounds/speech_to_text_stop.wav'))
            }
        }, // print('onStatus: $val'),
        // ignore: avoid_print
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        await player.play(AssetSource('sounds/speech_to_text_listening.wav'));
        setState(() => _isListening = true);
        _speech.listen(
          cancelOnError: true,
          onResult: (val) => setState(() {
            _isListening = false;
            text = val.recognizedWords;
            final lowerCaseText = text.toLowerCase();
            //navigate to pages depending on service chosen
            if (lowerCaseText.contains("what categories do you have")) {
              speak(
                  "We provide services such as AC Repair, salon, appliance repair, painting, cleaning, plumbing, electrical, shifting and flooring.");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesPage(),
                ),
              );
            } else if (lowerCaseText.contains("ac repair")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcRepairPage(),
                ),
              );
            } else if (lowerCaseText.contains("salon")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SalonPage(),
                ),
              );
            } else if (lowerCaseText.contains("appliance repair")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApplianceRepairPage(),
                ),
              );
            } else if (lowerCaseText.contains("painting")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaintingPage(),
                ),
              );
            } else if (lowerCaseText.contains("cleaning")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CleaningPage(),
                ),
              );
            } else if (lowerCaseText.contains("plumbing")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlumbingPage(),
                ),
              );
            } else if (lowerCaseText.contains("electrical")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ElectricalPage(),
                ),
              );
            } else if (lowerCaseText.contains("shifting")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShiftingPage(),
                ),
              );
            } else if (lowerCaseText.contains("flooring")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlooringPage(),
                ),
              );
            }
          }),
        );
      }
    } else {
      await player.play(AssetSource('sounds/speech_to_text_stop.wav'));
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

Widget buildcard({required CardItem item}) => SizedBox(
      width: 200,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                child: Ink.image(
                  image: AssetImage(item.urlImage),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff020435),
              fontSize: 14,
              fontFamily: "Lato",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
