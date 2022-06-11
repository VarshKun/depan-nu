import 'package:depan_nu/auth/fb_sign_in.dart';
import 'package:depan_nu/auth/google_sign_in.dart';
import 'package:depan_nu/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
          ChangeNotifierProvider(create: (context) => FbSignInProvider())
        ],
        //create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          //color: Color(0xFFF1F5F9),
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF1F5F9),
            backgroundColor: const Color(0xFFF1F5F9),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      );
}
