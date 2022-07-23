import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FbSignInProvider extends ChangeNotifier {
  static LoginResult fbLoginDetails =
      LoginResult(status: LoginStatus.operationInProgress);
  Future fbLogin() async {
    try {
      fbLoginDetails = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential =
          FacebookAuthProvider.credential(fbLoginDetails.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userData['email'])
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        //already exists
        // ignore: avoid_print
        print("email already exists");
      } else {
        //does not exist
        await FirebaseFirestore.instance.collection('users').add({
          'full name': userData['name'],
          'email': userData['email'],
          'profile picture': userData['picture']['data']['url'],
          'bookings:': ''
        });
      }
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = "This account exists with a different sign in provider";
          break;
        case 'invalid-credential':
          content = "Unknown error has occurred";
          break;
        case 'operation-not-allowed':
          content = "This operation is not allowed";
          break;
        case 'user-disabled':
          content = "The user you tried to log into is disabled";
          break;
        case 'user-not-found':
          content = "The user you tried to log into was not found";
          break;
      }
      // ignore: avoid_print
      print(content);
    }

    notifyListeners();
  }

  Future logout() async {
    await FacebookAuth.instance.logOut();
    //var x = await FacebookAuth.instance.accessToken; if value is null, it means user signed in by email
    FirebaseAuth.instance.signOut();
  }

  Future<bool> emailAlreadyExist(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email ID', isEqualTo: email)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }
}
