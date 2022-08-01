// ignore: import_of_legacy_library_into_null_safe
import 'package:brand_colors/brand_colors.dart';
import 'package:depan_nu/bookings_page_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depan_nu/globalvariables.dart' as globals;
import 'package:line_icons/line_icons.dart';

class AcCheckUpPage extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _AcCheckUpPageState? instance;
  const AcCheckUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AcCheckUpPageState createState() => _AcCheckUpPageState();
}

class _AcCheckUpPageState extends State<AcCheckUpPage> {
  _AcCheckUpPageState() {
    AcCheckUpPage.instance = this;
  }

  void incrementUnits() {
    setState(() => {
          if (globals.noOfUnits != 10) {globals.noOfUnits++},
          globals.unitsCosts = globals.noOfUnits * 200
        });
  }

  void decrementUnits() {
    setState(() => {
          if (globals.noOfUnits != 1) {globals.noOfUnits--},
          globals.unitsCosts = globals.noOfUnits * 200
        });
  }

  void incrementRooms() {
    setState(() => {
          if (globals.noOfRooms != 10) {globals.noOfRooms++}
        });
  }

  void decrementRooms() {
    setState(() => {
          if (globals.noOfRooms != 1) {globals.noOfRooms--}
        });
  }

  void selectHome() {
    setState(() {
      globals.homeHasBeenPressed = true;
      globals.officeHasBeenPressed = false;
      globals.villaHasBeenPressed = false;
    });
  }

  void selectOffice() {
    setState(() {
      globals.homeHasBeenPressed = false;
      globals.officeHasBeenPressed = true;
      globals.villaHasBeenPressed = false;
    });
  }

  void selectVilla() {
    setState(() {
      globals.homeHasBeenPressed = false;
      globals.officeHasBeenPressed = false;
      globals.villaHasBeenPressed = true;
    });
  }

  void bookNow() {
    if (globals.homeHasBeenPressed) {
      globals.propertyType = "Home";
    } else if (globals.officeHasBeenPressed) {
      globals.propertyType = "Office";
    } else if (globals.villaHasBeenPressed) {
      globals.propertyType = "Villa";
    }
    // globals.noOfUnits =
    //     unitCount;
    globals.totalCost = globals.unitsCosts + globals.workersCosts;
    globals.acService = "AC Check-up";
    globals.categorySelected = "AC";
    (globals.homeHasBeenPressed ||
            globals.officeHasBeenPressed ||
            globals.villaHasBeenPressed)
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookingsMapPage(),
            ),
          )
        : null;
  }

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
                            "assets/images/subCat/AC/AC_CheckUp2.png"),
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
                BackButton(onPressed: () {
                  Navigator.pop(context);
                }),
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
                    "AC Check-Up",
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
                                  "Type of Property",
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
                                                  color: globals
                                                          .homeHasBeenPressed
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
                                                color: globals
                                                        .homeHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    selectHome();
                                                    // setState(() {
                                                    //   _homeHasBeenPressed =
                                                    //       !_homeHasBeenPressed;

                                                    //   _officeHasBeenPressed =
                                                    //       false;
                                                    //   _villaHasBeenPressed =
                                                    //       false;
                                                    // });
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
                                                      color: globals
                                                              .homeHasBeenPressed
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
                                                  color: globals
                                                          .officeHasBeenPressed
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
                                                color: globals
                                                        .officeHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    selectOffice();
                                                    // setState(() {
                                                    //   _officeHasBeenPressed =
                                                    //       !_officeHasBeenPressed;

                                                    //   _homeHasBeenPressed =
                                                    //       false;
                                                    //   _villaHasBeenPressed =
                                                    //       false;
                                                    // });
                                                  },
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 207, 203, 255),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      LineIcons.briefcase,
                                                      size: 45,
                                                      color: globals
                                                              .officeHasBeenPressed
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
                                          "Office",
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
                                                  color: globals
                                                          .villaHasBeenPressed
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
                                                color: globals
                                                        .villaHasBeenPressed
                                                    ? const Color(0xffCABDFF)
                                                    : const Color(0xFFF1F5F9),
                                                child: InkWell(
                                                  onTap: () {
                                                    selectVilla();
                                                    // setState(() {
                                                    //   _villaHasBeenPressed =
                                                    //       !_villaHasBeenPressed;

                                                    //   _homeHasBeenPressed =
                                                    //       false;
                                                    //   _officeHasBeenPressed =
                                                    //       false;
                                                    // });
                                                  },
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 207, 203, 255),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      LineIcons.hotel,
                                                      size: 45,
                                                      color: globals
                                                              .villaHasBeenPressed
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
                                          "Villa",
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
                                              "Number of units",
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
                                                      decrementUnits();
                                                      // setState(() {
                                                      //   globals.unitsCosts =
                                                      //       globals.noOfUnits *
                                                      //           200;
                                                      // });
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
                                                "${globals.noOfUnits}",
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
                                                      incrementUnits();
                                                      // setState(() {
                                                      //   globals.unitsCosts =
                                                      //       globals.noOfUnits *
                                                      //           200;
                                                      // });
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
                                  Expanded(
                                    child: Container(
                                      //color: Colors.amber,
                                      margin: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Number of rooms",
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
                                                      decrementRooms();
                                                      setState(() {
                                                        if (globals.noOfRooms >=
                                                            5) {
                                                          globals.workersCosts =
                                                              1000;
                                                          if (globals
                                                                  .noOfRooms >=
                                                              8) {
                                                            globals.workersCosts =
                                                                2000;
                                                          }
                                                        } else {
                                                          globals.workersCosts =
                                                              500;
                                                        }
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
                                                "${globals.noOfRooms}",
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
                                                      incrementRooms();
                                                      setState(() {
                                                        if (globals.noOfRooms >=
                                                            5) {
                                                          globals.workersCosts =
                                                              1000;
                                                          if (globals
                                                                  .noOfRooms >=
                                                              8) {
                                                            globals.workersCosts =
                                                                2000;
                                                          }
                                                        } else {
                                                          globals.workersCosts =
                                                              500;
                                                        }
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
                                                      "Rs ${globals.unitsCosts}",
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
                                                      "Rs ${globals.workersCosts}",
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
                                                      "Rs ${globals.unitsCosts + globals.workersCosts}",
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
                                                        color: (globals.homeHasBeenPressed ||
                                                                globals
                                                                    .officeHasBeenPressed ||
                                                                globals
                                                                    .villaHasBeenPressed)
                                                            ? const Color(
                                                                0xff6759FF)
                                                            : BrandColors
                                                                .viberGray,
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              bookNow();
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
