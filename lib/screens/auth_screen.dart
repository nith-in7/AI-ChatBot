import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 43, 52, 52),
              Color.fromARGB(255, 43, 52, 52),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: const Text(
          "Chat Mate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 48, 48, 47),
            Color.fromARGB(255, 40, 40, 39)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: .5, color: Color.fromARGB(178, 255, 255, 255))),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultTextStyle(
                  style: TextStyle(fontSize: 60, height: 1.2),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Explore\n"),
                        TextSpan(text: "infinite\n"),
                        TextSpan(
                            text: "capabilities\n",
                            style: TextStyle(
                                color: Color.fromARGB(255, 170, 185, 141))),
                        TextSpan(text: "of writing")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _getContainer(
                    icon: Icons.psychology_outlined,
                    title:
                        "Remembers what user said earlier in the conversation",
                    context: context),
                const SizedBox(
                  height: 10,
                ),
                _getContainer(
                    context: context,
                    icon: Icons.border_color_outlined,
                    title: "Allows user to provide follow-up corrections"),
                const SizedBox(
                  height: 10,
                ),
                _getContainer(
                    context: context,
                    icon: Icons.new_releases_outlined,
                    title: "Trained to decline inappropriate requests"),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GlowButton(
                    spreadRadius: 0.2,
                    offset: Offset.zero,
                    height: 50,
                    width: 364,
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    onPressed: () {
                      signInWithGoogle(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getContainer({required String title, required IconData icon, context}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            width: 0.3, color: const Color.fromARGB(137, 255, 255, 255)),
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        color: const Color.fromARGB(39, 255, 255, 255)),
    child: ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 364,
          height: 90,
          child: Row(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  border: Border.all(width: .5, color: Colors.black),
                  borderRadius: BorderRadius.circular(32),
                  color: const Color.fromARGB(167, 0, 0, 0),
                ),
                child: GlowIcon(
                  offset: Offset.zero,
                  blurRadius: 30,
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Text(
                    style: const TextStyle(color: Colors.white),
                    title,
                    softWrap: true,
                    maxLines: 2,
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

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
