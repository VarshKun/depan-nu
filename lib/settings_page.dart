import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'auth/fb_sign_in.dart';
import 'auth/google_sign_in.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  var accessToken = FbSignInProvider.fbLoginDetails.accessToken?.token;
  String imageUrl = "";
  bool isDarkMode = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    var profileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.only(top: 35),
            child: Stack(
              children: [
                user.photoURL == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(imageUrl),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          accessToken == null
                              ? user.photoURL!
                              : "${user.photoURL!}?height=1000&access_token=$accessToken",
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xffDFB349),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LineAwesomeIcons.pencil,
                      color: Color(0xff020435),
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          user.displayName == null
              ? const Text(
                  "Username not found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff020435),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              : Text(
                  user.displayName!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xff020435),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
          const SizedBox(
            height: 5,
          ),
          user.email == null
              ? const Text(
                  "Email not found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff020435),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )
              : Text(
                  user.email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xff020435),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
          // const SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 10,
        ),
        const Icon(
          LineAwesomeIcons.arrow_left,
          size: 30,
          color: Color(0xff020435),
        ),
        profileInfo,
        //themeSwitcher,
        const SizedBox(
          width: 40,
        ),
      ],
    );

    return Scaffold(
      //backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          header,
          GestureDetector(
            onTap: () {
              if (isDarkMode == false) {
                isDarkMode = true;
                controller.animateTo(0.6);
              } else {
                isDarkMode = false;
                controller.animateBack(0.0);
              }
            },
            child: Lottie.asset(
              "assets/animations/Dark-Mode.json",
              width: 100,
              height: 45,
              controller: controller,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.user,
                    text: 'Account Settings',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.money,
                    text: 'E-Wallet',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.history,
                    text: 'Booking history',
                  ),
                ),
                GestureDetector(
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.question_circle,
                    text: 'Help & Support',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.user_plus,
                    text: 'Invite a Friend',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                    final provider2 =
                        Provider.of<FbSignInProvider>(context, listen: false);
                    provider2.logout();
                  },
                  child: const ProfileListItem(
                    icon: LineAwesomeIcons.sign_out,
                    text: 'Logout',
                    hasNavigation: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // child: MaterialButton(
      //   onPressed: () {
      // final provider =
      //     Provider.of<GoogleSignInProvider>(context, listen: false);
      // provider.logout();
      // final provider2 =
      //     Provider.of<FbSignInProvider>(context, listen: false);
      // provider2.logout();
      //   },
      //   color: Colors.deepPurple[200],
      //   child: const Text('sign out'),
      // ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  // ignore: prefer_typing_uninitialized_variables
  final text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 239, 255),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: const Color(0xff020435),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff020435),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (hasNavigation)
            const Icon(
              LineAwesomeIcons.angle_right,
              size: 30,
              color: Color(0xff020435),
            )
        ],
      ),
    );
  }
}
