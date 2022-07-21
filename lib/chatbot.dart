import 'package:depan_nu/messages.dart';
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
      if (commandName == "showAlert") {
        /// handle command "showAlert"
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
}
