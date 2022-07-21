import 'package:carbon_icons/carbon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depan_nu/auth/fb_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  var accessToken = FbSignInProvider.fbLoginDetails.accessToken?.token;
  String imageUrl = "";

  void _getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // ignore: avoid_print
        print('Document data: ${documentSnapshot.data()}');
        setState(() {
          imageUrl = (documentSnapshot.data() as Map)['profile picture'];
        });
      } else {
        // ignore: avoid_print
        print('Document doesnt exist');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          CarbonIcons.bot,
          color: Color(0xff020435),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 228, 239, 255),
        title: const Text(
          "Depan-Nu chatbot",
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.w800,
            color: Color(0xff020435),
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: widget.messages[index]['isUserMessage']
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  widget.messages[index]['isUserMessage'] == false
                      ? const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/robot.jpg"),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(
                          20,
                        ),
                        topRight: const Radius.circular(20),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMessage']
                          ? const Color.fromRGBO(2, 4, 53, 0.9)
                          : const Color.fromRGBO(2, 4, 53, 0.8),
                    ),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(
                      widget.messages[index]['message'].text.text[0],
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  widget.messages[index]['isUserMessage']
                      ? SizedBox(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              accessToken == null
                                  ? imageUrl
                                  : "${user.photoURL!}?height=1000&access_token=$accessToken",
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
          separatorBuilder: (_, i) =>
              const Padding(padding: EdgeInsets.only(top: 10)),
          itemCount: widget.messages.length),
    );
  }
}
