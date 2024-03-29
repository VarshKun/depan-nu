import 'package:depan_nu/all_categories.dart';
import 'package:depan_nu/chatbot.dart';
import 'package:depan_nu/map.dart';
import 'package:depan_nu/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'bookings_page.dart';
import 'home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shake/shake.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class CardItem {
  final String urlImage;
  final String title;

  const CardItem({required this.urlImage, required this.title});
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int currentIndex = 0;
  late ShakeDetector detector;

  final screens = [
    const HomePage(),
    const MapPage(),
    const BookingsPage(),
    const ChatBot(),
    const SettingsPage(),
  ];

  // ignore: non_constant_identifier_names
  checkPermission_microphone() async {
    var microphoneStatus = await Permission.microphone.status;
    // ignore: avoid_print
    print(microphoneStatus);

    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }

    if (await Permission.microphone.isGranted) {
      setState(() {
        currentIndex = 3;
      });
    } else {
      showToast("Provide access to microphone to access chatbot",
          position: ToastPosition.center);
    }
  }

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoriesPage(),
          ),
        );
      },
      minimumShakeCount: 3,
    );
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //return WillPopScope(
    //onWillPop: () async => false,
    return Scaffold(
      //extendBody: true,
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 228, 239, 255),
        index: currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        //backgroundColor: const Color(0xFFF1F5F9),
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (currentIndex == 3) {
              checkPermission_microphone();
            }
          });
          //Handle button tap
        },
        items: <Widget>[
          Icon(
            CarbonIcons.home,
            size: 30,
            color: currentIndex == 0 ? Colors.amber : const Color(0xff020435),
          ),
          Icon(CarbonIcons.location,
              size: 30,
              color: currentIndex == 1 ? Colors.amber : const Color(0xff020435)
              //: const Color.fromRGBO(2, 4, 54, 0.5),
              ),
          Icon(
            CarbonIcons.calendar,
            size: 30,
            color: currentIndex == 2 ? Colors.amber : const Color(0xff020435),
          ),
          Icon(
            CarbonIcons.chat,
            size: 30,
            color: currentIndex == 3 ? Colors.amber : const Color(0xff020435),
          ),
          Icon(
            CarbonIcons.settings,
            size: 30,
            color: currentIndex == 4 ? Colors.amber : const Color(0xff020435),
            //: const Color.fromRGBO(2, 4, 54, 0.5),
          ),
        ],
      ),
    );
    //);
  }
}
