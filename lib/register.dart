import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'components/login_register_button.dart';
import 'components/social_media_fb.dart';
import 'components/social_media_google.dart';
import 'components/social_media_phone.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPage> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool emailAlreadyInUse = false;
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  late File _pickedImage;
  late String url;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed() && enteredName()) {
      // create user
      try {
        // ignore: unnecessary_null_comparison
        if (_pickedImage == null) {
          // ignore: avoid_print
          print('please pick image');
        } else {
          final ref = FirebaseStorage.instance
              .ref()
              .child('userImages')
              // ignore: prefer_interpolation_to_compose_strings
              .child(_fullNameController.text.trim() + '.jpg');

          await ref.putFile(_pickedImage);
          url = await ref.getDownloadURL();
        }
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (_emailFormKey.currentState!.validate() &&
            _passwordFormKey.currentState!.validate() &&
            _nameFormKey.currentState!.validate()) {
          //add user details if password good
          addUserDetails(
            _fullNameController.text.trim(),
            _emailController.text.trim(),
            url,
          );
        }
      } catch (signUpError) {
        if (signUpError is FirebaseAuthException) {
          if (signUpError.code == 'email-already-in-use') {
            /// `foo@bar.com` has already been registered.
            setState(() {
              emailAlreadyInUse = true;
            });
          }
        }
      }
    } else {
      _emailFormKey.currentState!.validate();
      _passwordFormKey.currentState!.validate();
      _nameFormKey.currentState!.validate();
    }
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 100,
    );

    setState(() {
      _pickedImage = File(image!.path);
    });
  }

  Future addUserDetails(String fullName, String email, String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    //setState(() {
    user?.updateDisplayName(fullName);
    //});
    await FirebaseAuth.instance.currentUser?.reload();
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'email': email,
      'full name': fullName,
      'profile picture': imageUrl,
      'bookings': ''
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool enteredName() {
    if (_fullNameController.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              // const SizedBox(
              //   height: 0,
              // ),
              const Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedImage(),
                ),
              ),
              Expanded(
                flex: 7,
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
                              "Sign up",
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
                        // const SizedBox(
                        //   height: 2,
                        // ),

                        //social sign in
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
                        const Text(
                          "Or, register with email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x5b010435),
                            fontSize: 20,
                            fontFamily: "Lato",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            //Color(0xffdfb349)
                            InkWell(
                              onTap: () {
                                pickUploadImage();
                              },
                              splashColor: const Color(0xffdfb349),
                              child: const Text(
                                "Add a profile picture",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0x5b010435),
                                  fontSize: 20,
                                  fontFamily: "Lato",
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // email textfield
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
                          height: 5,
                        ),

                        //full name textfield
                        SizedBox(
                          width: 300,
                          child: Form(
                            key: _nameFormKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              controller: _fullNameController,
                              validator: validateEmptyField,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "Full Name",
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
                                  Icons.person_outline,
                                  color: Color(0x5b010435),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //password textfield
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
                        const SizedBox(
                          height: 5,
                        ),

                        //confirm password textfield
                        SizedBox(
                          width: 300,
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              controller: _confirmPassController,
                              validator: (val) {
                                if (val != _passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              obscureText: obscureConfirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Confirm password",
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
                                  onPressed: () => setState(() =>
                                      obscureConfirmPassword =
                                          !obscureConfirmPassword),
                                  icon: Icon(obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        login_register_button(
                          text: "Register",
                          press: signUp,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                                    "Already a member?",
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
                                onTap: widget.showLoginPage,
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 125,
                                    height: 33,
                                    child: Text(
                                      "Login Here",
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
      if (!(value.length > 5 && value.contains('@'))) {
        return 'Enter a valid e-mail ID';
      }
      if (emailAlreadyInUse) {
        return 'Email is already in use. Please enter a valid e-mail ID';
      }
    }
    return null;
  }

  // ignore: body_might_complete_normally_nullable
  String? validatePassword(String? value) {
    // ignore: unnecessary_null_comparison
    if (value!.isEmpty || value == null) {
      return 'This is a required field';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
  }

  String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return 'This is a required field';
    }
    return null;
  }
}

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
      child: Image.asset("assets/images/register_Illus.png"),
    );
  }
}
