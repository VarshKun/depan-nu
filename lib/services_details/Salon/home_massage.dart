// ignore: import_of_legacy_library_into_null_safe
import 'package:brand_colors/brand_colors.dart';
import 'package:depan_nu/bookings_page_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depan_nu/globalvariables.dart' as globals;
import 'package:line_icons/line_icons.dart';

class MassagePage extends StatefulWidget {
  const MassagePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MassagePageState createState() => _MassagePageState();
}

class _MassagePageState extends State<MassagePage> {
  bool _weddingHasBeenPressed = false;
  bool _homeHasBeenPressed = false;
  bool _eventHasBeenPressed = false;
  int personCount = 1;
  int roomCount = 1;
  int personsCost = 1000;
  int workersCosts = 500;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xff3F3F3F).withOpacity(0.8),
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                    ]),
                    image: const DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                            "assets/images/subCat/Salon/homeMassage2.png"),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xff3F3F3F).withOpacity(0.0),
                      const Color(0xff3F3F3F).withOpacity(0.1),
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
                const BackButton(),
                Container(
                  width: 45,
                  height: 25,
                  margin: const EdgeInsets.only(top: 85, left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "assets/images/icons/starWhite.png",
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        "4.5",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 20, top: 120),
                  child: const Text(
                    "Massage",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 210, right: 20),
                  width: 320,
                  height: 510,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
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
                                "assets/images/icons/tagPurple.png",
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(
                                child: Text(
                                  "Occasion type",
                                  style: TextStyle(
                                    color: Color(0xff020435),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xffb7cce0),
                                                  blurRadius: 2,
                                                  offset: Offset(-2, -2),
                                                ),
                                                BoxShadow(
                                                  color: _homeHasBeenPressed
                                                      ? const Color.fromARGB(
                                                          255,
                                                          185,
                                                          173,
                                                          233,
                                                        )
                                                      : const Color(0xffffffff),
                                                  blurRadius: 0,
                                                  offset: const Offset(-1, -1),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Material(
                                                color: _homeHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _homeHasBeenPressed =
                                                          !_homeHasBeenPressed;

                                                      _weddingHasBeenPressed =
                                                          false;
                                                      _eventHasBeenPressed =
                                                          false;
                                                    });
                                                  },
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                    255,
                                                    207,
                                                    203,
                                                    255,
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      LineIcons.home,
                                                      size: 45,
                                                      color: _homeHasBeenPressed
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff6759FF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Home",
                                          style: TextStyle(
                                            color: Color(0xff020435),
                                            fontSize: 15,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xffb7cce0),
                                                  blurRadius: 2,
                                                  offset: Offset(-2, -2),
                                                ),
                                                BoxShadow(
                                                  color: _eventHasBeenPressed
                                                      ? const Color.fromARGB(
                                                          255,
                                                          185,
                                                          173,
                                                          233,
                                                        )
                                                      : const Color(0xffffffff),
                                                  blurRadius: 0,
                                                  offset: const Offset(-1, -1),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Material(
                                                color: _eventHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _eventHasBeenPressed =
                                                          !_eventHasBeenPressed;

                                                      _homeHasBeenPressed =
                                                          false;
                                                      _weddingHasBeenPressed =
                                                          false;
                                                    });
                                                  },
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 207, 203, 255),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      LineIcons.glassCheers,
                                                      size: 45,
                                                      color:
                                                          _eventHasBeenPressed
                                                              ? Colors.white
                                                              : const Color(
                                                                  0xff6759FF),
                                                    ),
                                                    // child: Image.asset(
                                                    //     "assets/images/icons/office.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Event",
                                          style: TextStyle(
                                            color: Color(0xff020435),
                                            fontSize: 15,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xffb7cce0),
                                                  blurRadius: 2,
                                                  offset: Offset(-2, -2),
                                                ),
                                                BoxShadow(
                                                  color: _weddingHasBeenPressed
                                                      ? const Color.fromARGB(
                                                          255,
                                                          185,
                                                          173,
                                                          233,
                                                        )
                                                      : const Color(0xffffffff),
                                                  blurRadius: 0,
                                                  offset: const Offset(-1, -1),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Material(
                                                color: _weddingHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _weddingHasBeenPressed =
                                                          !_weddingHasBeenPressed;

                                                      _homeHasBeenPressed =
                                                          false;
                                                      _eventHasBeenPressed =
                                                          false;
                                                    });
                                                  },
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 207, 203, 255),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      LineIcons.ring,
                                                      size: 45,
                                                      color:
                                                          _weddingHasBeenPressed
                                                              ? Colors.white
                                                              : const Color(
                                                                  0xff6759FF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Wedding",
                                          style: TextStyle(
                                            color: Color(0xff020435),
                                            fontSize: 15,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
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
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      //color: Colors.amber,
                                      margin: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Number of persons",
                                              style: TextStyle(
                                                color: Color(0xff020435),
                                                fontSize: 17,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Material(
                                                  color:
                                                      const Color(0xff6759FF),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (personCount != 1) {
                                                          personCount--;
                                                        }

                                                        if (personCount >= 3) {
                                                          workersCosts = 1000;
                                                          if (personCount >=
                                                              5) {
                                                            workersCosts = 2000;
                                                          }
                                                        } else {
                                                          workersCosts = 500;
                                                        }
                                                        personsCost =
                                                            personCount * 1000;
                                                      });
                                                    },
                                                    highlightColor:
                                                        const Color.fromARGB(
                                                            255, 207, 203, 255),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 40,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "$personCount",
                                                style: const TextStyle(
                                                  color: Color(0xff020435),
                                                  fontSize: 17,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Material(
                                                  color:
                                                      const Color(0xff6759FF),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (personCount != 10) {
                                                          personCount++;
                                                        }
                                                        if (personCount >= 3) {
                                                          workersCosts = 1000;
                                                          if (personCount >=
                                                              5) {
                                                            workersCosts = 2000;
                                                          }
                                                        } else {
                                                          workersCosts = 500;
                                                        }
                                                        personsCost =
                                                            personCount * 1000;
                                                      });
                                                    },
                                                    highlightColor:
                                                        const Color.fromARGB(
                                                            255, 207, 203, 255),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 40,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
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
                            Expanded(
                              flex: 2,
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
                                            "assets/images/icons/tagPurple.png",
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "Estimated bill",
                                            style: TextStyle(
                                              color: Color(0xff020435),
                                              fontSize: 18,
                                              fontFamily: "Lato",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        bottom: 5,
                                      ),
                                      color: const Color.fromARGB(
                                          59, 154, 159, 165),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    child: const Text(
                                                      "Units costs",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 5,
                                                    ),
                                                    child: Text(
                                                      "Rs $personsCost",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    child: const Text(
                                                      "Worker costs",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 5,
                                                    ),
                                                    child: Text(
                                                      "Rs $workersCosts",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    child: const Text(
                                                      "Total",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 5,
                                                    ),
                                                    child: Text(
                                                      "Rs ${personsCost + workersCosts}",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xff020435),
                                                        fontSize: 17,
                                                        fontFamily: "Lato",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      //color: Colors.amberAccent,
                                                      ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    height: 50,
                                                    margin:
                                                        const EdgeInsets.all(4),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Material(
                                                        color: (_homeHasBeenPressed ||
                                                                _eventHasBeenPressed ||
                                                                _weddingHasBeenPressed)
                                                            ? const Color(
                                                                0xff6759FF)
                                                            : BrandColors
                                                                .viberGray,
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (_homeHasBeenPressed) {
                                                                globals.occasionType =
                                                                    "Home";
                                                              } else if (_eventHasBeenPressed) {
                                                                globals.occasionType =
                                                                    "Event";
                                                              } else if (_weddingHasBeenPressed) {
                                                                globals.occasionType =
                                                                    "Wedding";
                                                              }
                                                              globals.salonService =
                                                                  "Massage";
                                                              globals.noOfPersons =
                                                                  personCount;
                                                              globals.totalCost =
                                                                  personsCost +
                                                                      workersCosts;
                                                              globals.categorySelected =
                                                                  "Salon";
                                                              (_homeHasBeenPressed ||
                                                                      _eventHasBeenPressed ||
                                                                      _weddingHasBeenPressed)
                                                                  ? Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const BookingsMapPage(),
                                                                      ),
                                                                    )
                                                                  : null;
                                                            });
                                                          },
                                                          highlightColor:
                                                              const Color
                                                                  .fromARGB(
                                                            255,
                                                            207,
                                                            203,
                                                            255,
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "Book Now",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Lato",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      //color: Colors.amberAccent,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
