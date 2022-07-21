import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      } else {
        _user = googleUser;

        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _user?.email)
            .get();

        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isNotEmpty) {
          //already exists
          // ignore: avoid_print
          print("email already exists");
        } else {
          //email does not exist
          await FirebaseFirestore.instance.collection('users').add({
            'full name': _user?.displayName,
            'email': _user?.email,
            'profile picture': _user?.photoUrl,
          });
        }
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    if (googleSignIn.currentUser == null) {
      FirebaseAuth.instance.signOut();
    } else {
      await googleSignIn.disconnect();
    }
  }
}
