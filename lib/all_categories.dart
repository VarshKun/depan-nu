import 'package:depan_nu/subcategories/ac_repair.dart';
import 'package:depan_nu/subcategories/appliance_repair.dart';
import 'package:depan_nu/subcategories/cleaning.dart';
import 'package:depan_nu/subcategories/electrical.dart';
import 'package:depan_nu/subcategories/flooring.dart';
import 'package:depan_nu/subcategories/painting.dart';
import 'package:depan_nu/subcategories/plumbing.dart';
import 'package:depan_nu/subcategories/salon.dart';
import 'package:depan_nu/subcategories/shifting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String text = 'Select the service you need';
  late stt.SpeechToText _speech;
  bool _isListening = false;
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

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
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
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
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
                                (word) => word.toLowerCase().contains(
                                    textEditingvalue.text.toLowerCase()),
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
                                      textStyleHighlight: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    onTap: () {
                                      onSelected(option.toString());
                                    },
                                  );
                                },
                                itemCount: options.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            );
                          },
                          onSelected: (selectedString) {
                            //print(selectedString);
                            if (selectedString == "AC Repair") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AcRepairPage(),
                                ),
                              );
                            } else if (selectedString == "Salon") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SalonPage(),
                                ),
                              );
                            } else if (selectedString == "Appliance Repair") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ApplianceRepairPage(),
                                ),
                              );
                            } else if (selectedString == "Painting") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaintingPage(),
                                ),
                              );
                            } else if (selectedString == "Cleaning") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CleaningPage(),
                                ),
                              );
                            } else if (selectedString == "Plumbing") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlumbingPage(),
                                ),
                              );
                            } else if (selectedString == "Electrical") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ElectricalPage(),
                                ),
                              );
                            } else if (selectedString == "Shifting") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShiftingPage(),
                                ),
                              );
                            } else if (selectedString == "Flooring") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FlooringPage(),
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
                                if (value == "AC Repair" ||
                                    value.toLowerCase() == "ac repair") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AcRepairPage(),
                                    ),
                                  );
                                } else if (value == "Salon" ||
                                    value.toLowerCase() == "salon") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SalonPage(),
                                    ),
                                  );
                                } else if (value == "Appliance Repair" ||
                                    value.toLowerCase() == "appliance repair") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ApplianceRepairPage(),
                                    ),
                                  );
                                } else if (value == "Painting" ||
                                    value.toLowerCase() == "painting") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PaintingPage(),
                                    ),
                                  );
                                } else if (value == "Cleaning" ||
                                    value.toLowerCase() == "cleaning") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CleaningPage(),
                                    ),
                                  );
                                } else if (value == "Plumbing" ||
                                    value.toLowerCase() == "plumbing") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PlumbingPage(),
                                    ),
                                  );
                                } else if (value == "Electrical" ||
                                    value.toLowerCase() == "electrical") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ElectricalPage(),
                                    ),
                                  );
                                } else if (value == "Shifting" ||
                                    value.toLowerCase() == "shifting") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ShiftingPage(),
                                    ),
                                  );
                                } else if (value == "Flooring" ||
                                    value.toLowerCase() == "flooring") {
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
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
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
                                    child: Image.asset(
                                        "assets/images/icons/tagPurple.png"),
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        "All categories",
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
                              flex: 8,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffffcbb0),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/ACRepair.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "AC Repair",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffD7CDFF),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Salon.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Salon",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffC1ECFF),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Appliance.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Appliance Repair",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PaintingPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffC2F9DA),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Painting.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Painting",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                            const CleaningPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffFFE0A3),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Cleaning.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Cleaning",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                            const PlumbingPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffDBF8B6),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Plumbing.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Plumbing",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ElectricalPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffFFC4C4),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Electronics.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Electrical",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                            const ShiftingPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffFFC6F6),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Shifting.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Shifting",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                            const FlooringPage(),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffC8D8FF),
                                                    fixedSize:
                                                        const Size(200, 100),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/icons/Flooring.png",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Flooring",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xcc010435),
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
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
                          ],
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
            ),
          );
        },
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
            if (lowerCaseText.contains("what categories do you have")) {
              //we have blablabla
              speak(
                  "We provide services such as AC Repair, salon, appliance repair, painting, cleaning, plumbing, electrical, shifting and flooring.");
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
