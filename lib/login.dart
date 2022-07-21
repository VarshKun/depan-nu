import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/login_register_button.dart';
import 'components/social_media_fb.dart';
import 'components/social_media_google.dart';
import 'components/social_media_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  var loading = false;
  //text controllers
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      if (_emailFormKey.currentState!.validate() &&
          _passwordFormKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('Failed with error code: ${e.code}');
      // ignore: avoid_print
      print(e.message);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //disable navbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Expanded(
                flex: 3,
                child: AnimatedImage(),
                // child: Container(
                //   color: Colors.amber,
                // ),
              ),
              Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              //color: Colors.red,
                              ),
                        ),
                        const Expanded(
                          flex: 18,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff020435),
                                fontSize: 32,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _emailFormKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              decoration: const InputDecoration(
                                hintText: "E-mail ID",
                                hintStyle: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 20,
                                  color: Color(0x5b010435),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x5b010435),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0x5b010435),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _passwordFormKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              controller: _passwordController,
                              validator: validatePassword,
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 20,
                                  color: Color(0x5b010435),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x5b010435),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0x5b010435),
                                ),
                                suffixIcon: IconButton(
                                  color: const Color(0xFF020435),
                                  onPressed: () => setState(
                                      () => obscurePassword = !obscurePassword),
                                  icon: Icon(obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Align(
                            alignment: Alignment(0.8, 0),
                            child: Text(
                              "Forgot?",
                              style: TextStyle(
                                color: Color(0xffdfb349),
                                fontSize: 18,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        login_register_button(
                          text: "Login",
                          press: signIn,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Or, log in with",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x5b010435),
                            fontSize: 20,
                            fontFamily: "Lato",
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //social icons
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 102,
                              height: 80,
                              child: social_media_fb(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 102,
                              height: 80,
                              child: social_media_google(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 102,
                              height: 80,
                              child: social_media_phone(),
                            )
                          ],
                        ),
                        //register line
                        SizedBox(
                          width: 300,
                          height: 33,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 173.41,
                                  height: 33,
                                  child: Text(
                                    "New to Depan-Nu?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0x5b010435),
                                      fontSize: 20,
                                      fontFamily: "Lato",
                                      //fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.showRegisterPage,
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 125,
                                    height: 33,
                                    child: Text(
                                      "Register Now",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xffdfb349),
                                        fontSize: 20,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // child: Container(
                //   color: Colors.white,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
    }
    return 'Enter a valid e-mail ID';
  }

  // ignore: body_might_complete_normally_nullable
  String? validatePassword(String? value) {
    // ignore: unnecessary_null_comparison
    if (value!.isEmpty || value == null) {
      return 'This is a required field';
    }
  }
}

//animation
class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.08),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset("assets/images/login_Illus.png"),
    );
  }
}
