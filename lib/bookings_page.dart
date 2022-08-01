import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  // ignore: unused_field, prefer_final_fields
  List<dynamic> _bookingList = [];
  List<Widget> bookingData = [];
  dynamic data;

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
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bookingData.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return bookingData[index];
                }),
          )
        ],
      ),
    );
  }

  Future getBookingsList() async {
    List<Widget> bookingDet = [];
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data();
        _bookingList = data['bookings'];
        for (var booking in _bookingList) {
          bookingDet.add(
            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Booking ID: ${booking['booking id']}',
                            style: const TextStyle(
                              color: Color(0xff020435),
                              fontSize: 16,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Date booked: ${booking['date']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff020435),
                              fontSize: 14,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Service : ${booking['service']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff020435),
                              fontSize: 15,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Served by: ${booking['served by']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff020435),
                              fontSize: 14,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Total cost: Rs ${booking['total cost']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff020435),
                              fontSize: 16,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: QrImage(
                        data: booking['no of rooms'] != null
                            ? "Booking id:  ${booking['booking id']}, Customer: ${booking['customer email']}, Booking date: ${booking['date']}, Service: ${booking['service']}, Worker: ${booking['served by']}, Type of property: ${booking['type of property']}, No of rooms: ${booking['no of rooms']}, No of units: ${booking['no of units']}, Total cost: ${booking['total cost']}"
                            : "Booking id:  ${booking['booking id']}, Customer: ${booking['customer email']}, Booking date: ${booking['date']}, Service: ${booking['service']}, Worker: ${booking['served by']}, Occasion type: ${booking['occasion type']}, No of persons: ${booking['no of persons']}, Total cost: ${booking['total cost']}",
                        gapless: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        bookingData = bookingDet;
      });
    });
  }
}
