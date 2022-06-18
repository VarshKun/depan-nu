import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int currentIndex = 0;

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
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //return WillPopScope(
    //onWillPop: () async => false,
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
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
                                                    child: user.photoURL == null
                                                        ? const SizedBox
                                                            .shrink()
                                                        : CircleAvatar(
                                                            radius: 40,
                                                            backgroundImage:
                                                                NetworkImage(user
                                                                    .photoURL!),
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
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff020435),
                                                            fontSize: 20,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                        user.displayName == null
                                                            ? const Text(
                                                                "Username not found",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff020435),
                                                                  fontSize: 24,
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
                                                                  fontSize: 24,
                                                                ),
                                                              ),
                                                        // Text(
                                                        //   user.displayName!,
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //     color: Color(
                                                        //         0xff020435),
                                                        //     fontSize: 24,
                                                        //   ),
                                                        // ),
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
                                      const Expanded(
                                        flex: 20,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: CupertinoSearchTextField(
                                            backgroundColor: Colors.white,
                                            //backgroundColor: Color(0xfffbfbfb),
                                            placeholder:
                                                "Choose the service you need...",
                                            placeholderStyle: TextStyle(
                                              color: Color(0xff9b9e9f),
                                              fontSize: 18,
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
                                            suffixMode: OverlayVisibilityMode
                                                .notEditing,
                                            suffixIcon: Icon(
                                              Icons.mic,
                                              color: Color(0xff4EFF3F),
                                              size: 30,
                                            ),
                                            //onSuffixTap: , USE IT TO ADD FUNCTIONALITY TO SUFFIX ICON
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
                                      borderRadius: BorderRadius.circular(8),
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
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
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
                                              const Text(
                                                "AC Repair",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xcc010435),
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
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
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
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
                                              const Text(
                                                "Salon",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xcc010435),
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
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
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
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
                                              const Text(
                                                "Appliance Repair",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xcc010435),
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
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
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xffFAFAFA),
                                                  fixedSize:
                                                      const Size(200, 100),
                                                  shape: const CircleBorder(),
                                                ),
                                                child: Image.asset(
                                                  "assets/images/icons/SeeAll.png",
                                                  width: 45,
                                                  height: 45,
                                                ),
                                              ),
                                              const Text(
                                                "See All",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xcc010435),
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  fontWeight: FontWeight.w500,
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
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Image.asset(
                                                    "assets/images/icons/tag.png"),
                                              ),
                                              const Expanded(
                                                child: SizedBox(
                                                  child: Text(
                                                    "Cleaning Services",
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
                                                    color: Color(0xff6f767d),
                                                    fontSize: 14,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                  BorderRadius.circular(100),
                                              color: Colors.white,
                                            ),
                                            //padding: const EdgeInsets.all(3),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Grab Offer",
                                                  style: TextStyle(
                                                    color: Color(0xff6a9b7e),
                                                    fontSize: 14,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                        borderRadius: BorderRadius.circular(14),
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
                                            mainAxisSize: MainAxisSize.min,
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
                                                    color: Color(0xff020435),
                                                    fontSize: 13,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const SizedBox(
                                                width: 241,
                                                child: Text(
                                                  "Get 15%",
                                                  style: TextStyle(
                                                    color: Color(0xff020435),
                                                    fontSize: 48,
                                                    fontFamily: "Lato",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
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
                                                              Color(0xff83C1DE),
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
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        const Color(0xffeceaf6),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
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
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Offer Dry Cleaning",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff020435),
                                                            fontSize: 13,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      const SizedBox(
                                                        width: 241,
                                                        child: Text(
                                                          "Get 25%",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff020435),
                                                            fontSize: 48,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                            color: Colors.white,
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

                    // Text('Name: ${user.displayName!}'),
                    // Text('signed in as ${user.email!}'),
                    // MaterialButton(
                    //   onPressed: () {
                    //     final provider =
                    //         Provider.of<GoogleSignInProvider>(context, listen: false);
                    //     provider.logout();
                    //     final provider2 =
                    //         Provider.of<FbSignInProvider>(context, listen: false);
                    //     provider2.logout();
                    //   },
                    //   color: Colors.deepPurple[200],
                    //   child: const Text('sign out'),
                    // )
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
