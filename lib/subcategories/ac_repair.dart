import 'package:depan_nu/services_details/AC/ac_check_up.dart';
import 'package:depan_nu/services_details/AC/ac_installation.dart';
import 'package:depan_nu/services_details/AC/ac_regular_service.dart';
import 'package:depan_nu/services_details/AC/ac_uninstallation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AcRepairPage extends StatefulWidget {
  const AcRepairPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AcRepairPageState createState() => _AcRepairPageState();
}

class AcService {
  double rating = 0.0;
  String title = "";
  int cost = 0;
  String moreInfo = "";
  String imagePath = "";
  AcService(
      {required this.rating,
      required this.title,
      required this.cost,
      required this.moreInfo,
      required this.imagePath});
}

class _AcRepairPageState extends State<AcRepairPage> {
  List<AcService> acServicesList = [
    AcService(
      rating: 4.8,
      title: "AC Check-Up",
      cost: 2000,
      moreInfo: "AC Check-Up includes ",
      imagePath: "assets/images/subCat/AC/AC_CheckUp.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Regular Service",
      cost: 2000,
      moreInfo: "test2",
      imagePath: "assets/images/subCat/AC/AC_RegularService.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Installation",
      cost: 2500,
      moreInfo: "test3",
      imagePath: "assets/images/subCat/AC/AC_Installation.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Uninstallation",
      cost: 2500,
      moreInfo: "test4",
      imagePath: "assets/images/subCat/AC/AC_Uninstallation.png",
    )
  ];

  String text = 'Select the service you need';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  late TextEditingController controller;
  final FlutterTts flutterTts = FlutterTts();

  List<String> autoCompleteData = [
    "AC Check-up",
    "AC Regular Service",
    "AC Installation",
    "AC Uninstallation",
  ];

  Future speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    await flutterTts.setSpeechRate(0.5);
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            //flex: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: Autocomplete(
                optionsBuilder: (TextEditingValue textEditingvalue) {
                  if (textEditingvalue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  } else {
                    return autoCompleteData.where(
                      (word) => word
                          .toLowerCase()
                          .contains(textEditingvalue.text.toLowerCase()),
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
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: SubstringHighlight(
                            text: option.toString(),
                            term: controller.text,
                            textStyleHighlight:
                                const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            onSelected(option.toString());
                          },
                        );
                      },
                      itemCount: options.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  );
                },
                onSelected: (selectedString) {
                  //print(selectedString);
                  if (selectedString == "AC Regular Service") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcRegularServicePage(),
                      ),
                    );
                  } else if (selectedString == "AC Check-up") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcCheckUpPage(),
                      ),
                    );
                  } else if (selectedString == "AC Installation") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcInstallationPage(),
                      ),
                    );
                  } else if (selectedString == "AC Uninstallation") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcUninstallationPage(),
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
                  this.controller = controller;
                  return CupertinoSearchTextField(
                    onSubmitted: (value) {
                      if (value == "AC Check-up" ||
                          value.toLowerCase() == "ac check up") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AcCheckUpPage(),
                          ),
                        );
                      } else if (value == "AC Regular Service" ||
                          value.toLowerCase() == "ac regular service") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AcRegularServicePage(),
                          ),
                        );
                      } else if (value == "AC Installation" ||
                          value.toLowerCase() == "ac installation") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AcInstallationPage(),
                          ),
                        );
                      } else if (value == "AC Uninstallation" ||
                          value.toLowerCase() == "ac uninstallation") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AcUninstallationPage(),
                          ),
                        );
                      }
                    },
                    style: const TextStyle(
                      color: Color(0xff020435),
                      fontSize: 15,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                    ),
                    controller: controller,
                    focusNode: focusNode,
                    backgroundColor: Colors.white,
                    //backgroundColor: Color(0xfffbfbfb),
                    placeholder: text,
                    placeholderStyle: const TextStyle(
                      color: Color(0xff9b9e9f),
                      fontSize: 15,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                    ),
                    //itemSize: 50,
                    //itemColor: Color(0xff3C42E0),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xff9b9e9f),
                      size: 30,
                    ),
                    suffixMode: OverlayVisibilityMode.notEditing,
                    suffixIcon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: const Color(0xff4EFF3F),
                      size: 30,
                    ),
                    onSuffixTap: _listen,
                  );
                },
                //child:
              ),
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Expanded(
            flex: 8,
            child: Container(
              //padding: const EdgeInsets.only(bottom: 10),
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset("assets/images/icons/tagAC.png"),
                        ),
                        const Expanded(
                          flex: 4,
                          child: SizedBox(
                            child: Text(
                              "AC Repair",
                              style: TextStyle(
                                color: Color(0xff172b4d),
                                fontSize: 18,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: acServicesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            splashColor:
                                const Color.fromARGB(255, 227, 252, 250),
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AcCheckUpPage(),
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AcRegularServicePage(),
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AcInstallationPage(),
                                  ),
                                );
                              } else if (index == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AcUninstallationPage(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                            acServicesList[index].imagePath,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: Image.asset(
                                                      "assets/images/icons/star.png"),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  acServicesList[index]
                                                      .rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xff020435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 90,
                                              ),
                                              Expanded(
                                                child: PopupMenuButton(
                                                  offset: const Offset(10, 35),
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          <
                                                              PopupMenuEntry<
                                                                  MenuItem>>[
                                                    PopupMenuItem<MenuItem>(
                                                      child: Text(
                                                          acServicesList[index]
                                                              .moreInfo),
                                                    ),
                                                  ],
                                                  child: Column(
                                                    children: const [
                                                      Icon(
                                                        Icons
                                                            .info_outline_rounded,
                                                        color:
                                                            Color(0xff020435),
                                                        size: 25,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                acServicesList[index].title,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  color: Color(0xff020435),
                                                  fontSize: 18,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: const [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Starts From",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      125, 2, 4, 53),
                                                  fontSize: 16,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color:
                                                      const Color(0xff51dad0),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Rs ${acServicesList[index].cost}",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 14,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
    );
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
            if (lowerCaseText.contains("what services do you have")) {
              //we have blablabla
              speak(
                  "We do AC check ups, AC Regular service, AC installation and uninstallation.");
            } else if (lowerCaseText.contains("ac check up")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcCheckUpPage(),
                ),
              );
            } else if (lowerCaseText.contains("ac regular service")) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AcRegularServicePage(),
                  ),
                );
              });
            } else if (lowerCaseText.contains("ac installation")) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AcInstallationPage(),
                  ),
                );
              });
            } else if (lowerCaseText.contains("ac uninstallation")) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AcUninstallationPage(),
                  ),
                );
              });
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
