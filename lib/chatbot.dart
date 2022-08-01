import 'package:depan_nu/bookings_page_map.dart';
import 'package:depan_nu/main_page.dart';
import 'package:depan_nu/messages.dart';
import 'package:depan_nu/payment.dart';
import 'package:depan_nu/searchpage.dart';
import 'package:depan_nu/services_details/AC/ac_check_up.dart';
import 'package:depan_nu/services_details/AC/ac_installation.dart';
import 'package:depan_nu/services_details/AC/ac_regular_service.dart';
import 'package:depan_nu/services_details/AC/ac_uninstallation.dart';
import 'package:depan_nu/services_details/Salon/hair_dressing.dart';
import 'package:depan_nu/services_details/Salon/home_massage.dart';
import 'package:depan_nu/services_details/Salon/nail_manicure.dart';
import 'package:depan_nu/subcategories/ac_repair.dart';
import 'package:depan_nu/subcategories/salon.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool greetingPlayed = false;
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  _ChatBotState() {
    _initAlanButton();
  }

  void _initAlanButton() {
    AlanVoice.addButton(
        "2cb0a305561f5c319c77fc84fc8779b62e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    AlanVoice.onButtonState.add((state) {
      if (state.name == "ONLINE" && !greetingPlayed) {
        greetingPlayed = true;
        AlanVoice.activate();
        AlanVoice.playText(
            "Hello! I'm Alan, Depan Nu's voice bot. How can I help you?");
      }
    });

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
      var commandName = command.data["command"] ?? "";
      switch (commandName) {
        case "home page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
          break;
        case "ac repair page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcRepairPage(),
            ),
          );
          break;
        case "salon page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SalonPage(),
            ),
          );
          break;
        case "ac check up page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcCheckUpPage(),
            ),
          );
          break;
        case "ac regular service page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcRegularServicePage(),
            ),
          );
          break;
        case "ac installation page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcInstallationPage(),
            ),
          );
          break;
        case "ac uninstallation page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcUninstallationPage(),
            ),
          );
          break;
        case "hairdressing page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HairDressingPage(),
            ),
          );
          break;
        case "nail and toe manicure page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManicurePage(),
            ),
          );
          break;
        case "home massage page":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MassagePage(),
            ),
          );
          break;
        case "increment units":
          _incrementUnits();
          break;
        case "decrement units":
          _decrementUnits();
          break;
        case "increment rooms":
          _incrementRooms();
          break;
        case "decrement rooms":
          _decrementRooms();
          break;
        case "select home":
          _selectHome();
          break;
        case "select office":
          _selectOffice();
          break;
        case "select villa":
          _selectVilla();
          break;
        case "book now":
          _bookNow();
          break;
        case "search location":
          _searchBookingLocation();
          break;
        case "book worker":
          _bookWorker();
          break;
        case "make payment":
          _makePayment();
          break;
        case "confirm payment":
          _confirmPayment();
          break;
        case "back":
          Navigator.pop(context);
      }
    });

    AlanVoice.onEvent.add((event) {
      debugPrint("got new event ${event.data.toString()}");
    });

    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
    });
  }

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
    // /// Init Alan Button with project key from Alan Studio
    // AlanVoice.addButton(
    //     "2cb0a305561f5c319c77fc84fc8779b62e956eca572e1d8b807a3e2338fdd0dc/stage");

    // /// Handle commands from Alan Studio
    // AlanVoice.onCommand.add((command) {
    //   debugPrint("got new command ${command.toString()}");
    // });
  }

  @override
  void dispose() {
    super.dispose();
    AlanVoice.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: const Color(0xFFF1F5F9),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Enter question or say 'Hey Alan'",
                        hintStyle: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 20,
                          color: Color(0x5b010435),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x5b010435),
                          ),
                        ),
                        // prefixIcon: Icon(
                        //   CarbonIcons.chat_bot,
                        //   color: Color(0x5b010435),
                        // ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: const Color(0xff020435),
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                  // IconButton(
                  //   color: const Color(0xff020435),
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.mic),
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      const snackBar = SnackBar(content: Text("Text empty"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        addMessage(
          Message(
            text: DialogText(text: [text]),
          ),
          true,
        );
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );
      if (response.message == null) {
        return;
      }
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  //message that DialogFlowtter is returning
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  void _incrementUnits() {
    AcCheckUpPage.instance?.incrementUnits();
  }

  void _decrementUnits() {
    AcCheckUpPage.instance?.decrementUnits();
  }

  void _incrementRooms() {
    AcCheckUpPage.instance?.incrementRooms();
  }

  void _decrementRooms() {
    AcCheckUpPage.instance?.decrementRooms();
  }

  void _selectHome() {
    AcCheckUpPage.instance?.selectHome();
  }

  void _selectOffice() {
    AcCheckUpPage.instance?.selectOffice();
  }

  void _selectVilla() {
    AcCheckUpPage.instance?.selectVilla();
  }

  void _bookNow() {
    AcCheckUpPage.instance?.bookNow();
  }

  void _bookWorker() {
    SearchPage.instance?.bookWorker();
  }

  void _searchBookingLocation() {
    BookingsMapPage.instance?.searchLocation();
  }

  void _makePayment() {
    BookingsMapPage.instance?.makePayment();
  }

  void _confirmPayment() {
    PaymentsPage.instance?.confirmPayment();
  }
}
