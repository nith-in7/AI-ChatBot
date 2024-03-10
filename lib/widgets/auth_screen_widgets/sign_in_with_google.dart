import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

signInWithGoogle(context) async {
  final fireAuth = FirebaseAuth.instance;
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser != null) {
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      await fireAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "account-exists-with-different-credential") {
        message = "The account already exists with a different credential";
      } else if (e.code == "invalid-credential") {
        message = "Error occurred while accessing credentials. Try again.";
      } else {
        message = "Error occurred using Google Sign In. Try again.";
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
