import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<Object> _bookingList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBookingsList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Booking history",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff020435),
                fontSize: 32,
                fontFamily: "Lato",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getBookingsList() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print('AHHHHHHHHHHHHHHHHHHHHHHHHHHHH $data');
  }
}
