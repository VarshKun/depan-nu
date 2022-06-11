import 'dart:ui';
import 'package:depan_nu/auth/user_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/default_button.dart';
import 'onboard_content.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
  final PageController _pageViewController = PageController(initialPage: 0);

  List<Map<String, String>> onboardData = [
    {
      "text": "We provide professional services at a friendly price",
      "image": "assets/images/onboard1.png"
    },
    {
      "text": "Your satisfaction is our top priority",
      "image": "assets/images/onboard2.png"
    },
    {
      "text":
          "Instant, fast and reliable services at the tap of your fingertips",
      "image": "assets/images/onboard3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(133.50),
                          gradient: const LinearGradient(
                            begin: Alignment(
                                0.5017181759426654, 0.4999999970646479),
                            end: Alignment(
                                0.7800687001273421, 0.9330985195678282),
                            colors: [
                              Color.fromRGBO(81, 218, 208, 0.8),
                              Color.fromRGBO(81, 218, 208, 0.51),
                              Color.fromRGBO(241, 245, 249, 0.69),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //blur circle
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  PageView.builder(
                    controller: _pageViewController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onboardData.length,
                    itemBuilder: (context, index) => OnboardContent(
                      image: onboardData[index]["image"],
                      text: onboardData[index]['text'],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        onboardData.length, (index) => BuildDot(index: index)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  DefaultButton(
                    text: "Next",
                    press: () {
                      if (_pageViewController.page == 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserAuthenticationPage()),
                        );
                      } else {
                        _pageViewController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AnimatedContainer BuildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFFDFB349)
            : const Color(0xFF020435),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
