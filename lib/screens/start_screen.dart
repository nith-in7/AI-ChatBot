import 'package:ai_chat/widgets/display_container.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({super.key});

  @override
  State<ChatGPT> createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  int time = int.parse(DateFormat.H().format(DateTime.now()));
  late String greet;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (time >= 6 && time < 12) {
      greet = "Good\nMorning,\n";
    } else if (time >= 12 && time < 18) {
      greet = "Good\nAfternoon,\n";
    } else if (time >= 18 && time < 20) {
      greet = "Good\nEvening,\n";
    } else {
      greet = "Good\nTo See You,\n";
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 43, 52, 52),
            Color.fromARGB(255, 48, 48, 47),
            Color.fromARGB(255, 40, 40, 39)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 125,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    greet,
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 44,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.transparent,
                        foregroundImage:
                            AssetImage("assets/images/profile.jpeg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 48,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 170, 185, 141),
                ),
                child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                  TyperAnimatedText("Nithin",
                      textStyle: const TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 170, 185, 141))),
                  TyperAnimatedText("Ready to chat? "),
                  TyperAnimatedText("Ask me anything!"),
                  TyperAnimatedText("Explore your options"),
                  TyperAnimatedText("Discover something new today"),
                  TyperAnimatedText("Let's see what we can find"),
                ]),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Expanded(
              child: DisplayContainer(
                imageAddress: "assets/images/chatgpt_image.webp",
                  name: "ChatGPT",
                  desc:
                      "Ask anything and ChatGPT will be\nready to answer and help you",
                  title: "Let's Chat! \nChatGPT"),
            ),
            const SizedBox(
              height: 16,
            ),
            const Expanded(
              child: DisplayContainer(
                imageAddress: "assets/images/gemini_logo.svg",
                  name: "Gemini",
                  title: "Start Message!\nGemini",
                  desc:
                      "Ask away! Gemini, ready to answer\nyour questions and assist you."),
            ),
          ],
        ),
      ),
    );
  }
}
