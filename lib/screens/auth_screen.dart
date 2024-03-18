import 'dart:ui';

import 'package:ai_chat/provider/future_list_provider.dart';

import 'package:ai_chat/widgets/auth_screen_widgets/card_details.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void signInWithGoogle(context) async {
      final fireAuth = FirebaseAuth.instance;
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        try {
          await fireAuth.signInWithCredential(credential);
          ref.read(authScreenLoading.notifier).update((state) => false);
        } on FirebaseAuthException catch (e) {
          String message;
          if (e.code == "account-exists-with-different-credential") {
            message = "The account already exists with a different credential";
          } else if (e.code == "invalid-credential") {
            message = "Error occurred while accessing credentials. Try again.";
          } else {
            message = "Error occurred using Google Sign In. Try again.";
          }
          ref.read(authScreenLoading.notifier).update((state) => false);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      }
    }

    Widget content = Center(
      child: LoadingAnimationWidget.fourRotatingDots(
          color: const Color.fromARGB(255, 170, 185, 141), size: 60),
    );
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
      body: Stack(
        children: [
          Container(
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
                    const CardDetails(
                      icon: Icons.psychology_outlined,
                      title:
                          "Remembers what user said earlier in the conversation",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CardDetails(
                        icon: Icons.border_color_outlined,
                        title: "Allows user to provide follow-up corrections"),
                    const SizedBox(
                      height: 10,
                    ),
                    const CardDetails(
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
                          ref.read(authScreenLoading.notifier).update(
                                (state) => true,
                              );
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
          Visibility(
              visible: ref.watch(authScreenLoading),
              child: Positioned(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                        color: const Color.fromARGB(97, 0, 0, 0),
                        child: content)),
              ))
        ],
      ),
    );
  }
}
