import 'package:depan_nu/services_details/Salon/hair_dressing.dart';
import 'package:depan_nu/services_details/Salon/home_massage.dart';
import 'package:depan_nu/services_details/Salon/nail_manicure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SalonPage extends StatefulWidget {
  const SalonPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalonPageState createState() => _SalonPageState();
}

class SalonService {
  double rating = 0.0;
  String title = "";
  int cost = 0;
  String moreInfo = "";
  String imagePath = "";
  SalonService(
      {required this.rating,
      required this.title,
      required this.cost,
      required this.moreInfo,
      required this.imagePath});
}

class _SalonPageState extends State<SalonPage> {
  List<SalonService> salonServicesList = [
    SalonService(
      rating: 4.8,
      title: "Hair dressing",
      cost: 500,
      moreInfo: "test1",
      imagePath: "assets/images/subCat/Salon/hairdressing.png",
    ),
    SalonService(
      rating: 4.5,
      title: "Nail and toe manicure",
      cost: 500,
      moreInfo: "test2",
      imagePath: "assets/images/subCat/Salon/nailManicure.png",
    ),
    SalonService(
      rating: 4.5,
      title: "Home massage",
      cost: 1000,
      moreInfo: "test3",
      imagePath: "assets/images/subCat/Salon/homeMassage.png",
    ),
  ];

  String text = 'Select the service you need';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  late TextEditingController controller;
  final FlutterTts flutterTts = FlutterTts();

  List<String> autoCompleteData = [
    "Hair dressing",
    "Nail and toe manicure",
    "Home massage",
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
                  if (selectedString == "Hair dressing") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HairDressingPage(),
                      ),
                    );
                  } else if (selectedString == "Nail and toe manicure") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManicurePage(),
                      ),
                    );
                  } else if (selectedString == "Home massage") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MassagePage(),
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
                      if (value == "Hair dressing" ||
                          value.toLowerCase() == "hair dressing") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HairDressingPage(),
                          ),
                        );
                      } else if (value == "Nail and toe manicure" ||
                          value.toLowerCase() == "nail and toe manicure") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManicurePage(),
                          ),
                        );
                      } else if (value == "Home massage" ||
                          value.toLowerCase() == "home massage") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MassagePage(),
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
                          child:
                              Image.asset("assets/images/icons/tagSalon.png"),
                        ),
                        const Expanded(
                          flex: 4,
                          child: SizedBox(
                            child: Text(
                              "Salon",
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
                      itemCount: salonServicesList.length,
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
                                    builder: (context) =>
                                        const HairDressingPage(),
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ManicurePage(),
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MassagePage(),
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
                                            salonServicesList[index].imagePath,
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
                                                  salonServicesList[index]
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
                                                          salonServicesList[
                                                                  index]
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
                                                salonServicesList[index].title,
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
                                                      "Rs ${salonServicesList[index].cost}",
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
                  "We do hair dressing, nail and toe manicures as well as home massage.");
            } else if (lowerCaseText.contains("hair dressing")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HairDressingPage(),
                ),
              );
            } else if (lowerCaseText.contains("nail and toe manicure")) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManicurePage(),
                  ),
                );
              });
            } else if (lowerCaseText.contains("home massage")) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MassagePage(),
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
