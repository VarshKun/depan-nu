import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CleaningPageState createState() => _CleaningPageState();
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

class _CleaningPageState extends State<CleaningPage> {
  List<AcService> acServicesList = [
    AcService(
      rating: 4.8,
      title: "AC Check-Up",
      cost: 128,
      moreInfo: "AC Check-Up includes ",
      imagePath: "assets/images/subCat/AC/AC_CheckUp.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Regular Service",
      cost: 128,
      moreInfo: "test2",
      imagePath: "assets/images/subCat/AC/AC_RegularService.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Installation",
      cost: 170,
      moreInfo: "test3",
      imagePath: "assets/images/subCat/AC/AC_Installation.png",
    ),
    AcService(
      rating: 4.5,
      title: "AC Uninstallation",
      cost: 170,
      moreInfo: "test4",
      imagePath: "assets/images/subCat/AC/AC_Uninstallation.png",
    )
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          const Expanded(
            child: CupertinoSearchTextField(
              style: TextStyle(
                color: Color(0xff020435),
                fontSize: 15,
                fontFamily: "Lato",
                fontWeight: FontWeight.w500,
              ),
              //controller: _textController,
              backgroundColor: Colors.white,
              //backgroundColor: Color(0xfffbfbfb),
              placeholder: "Search category",
              placeholderStyle: TextStyle(
                color: Color(0xff9b9e9f),
                fontSize: 15,
                fontFamily: "Lato",
                fontWeight: FontWeight.w500,
              ),
              //itemSize: 50,
              //itemColor: Color(0xff3C42E0),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff9b9e9f),
                size: 30,
              ),
              suffixMode: OverlayVisibilityMode.notEditing,
              suffixIcon: Icon(
                Icons.mic_none,
                color: Color(0xff4EFF3F),
                size: 30,
              ),
              //onSuffixTap: _listen,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
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
                          child: Image.asset(
                              "assets/images/icons/tagCleaning.png"),
                        ),
                        const Expanded(
                          flex: 4,
                          child: SizedBox(
                            child: Text(
                              "Cleaning",
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
                            onTap: () {},
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
}
