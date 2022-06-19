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
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Depan-Nu chat Bot"),
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
                        vertical: 14, horizontal: 14),
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
                            ? Colors.grey.shade800
                            : Colors.grey.shade900.withOpacity(0.8)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(
                      widget.messages[index]['message'].text.text[0],
                      style: const TextStyle(color: Colors.white),
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
                            backgroundImage: NetworkImage(user.photoURL!),
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
