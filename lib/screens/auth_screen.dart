import 'package:ai_chat/widgets/auth_screen_widgets/card_details.dart';
import 'package:ai_chat/widgets/auth_screen_widgets/sign_in_with_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

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
                const CardDetails(
                  icon: Icons.psychology_outlined,
                  title: "Remembers what user said earlier in the conversation",
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
