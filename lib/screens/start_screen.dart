import 'dart:ui';
import 'package:ai_chat/screens/chat_screen.dart';
import 'package:ai_chat/widgets/display_container.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_hero/local_hero.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  int time = int.parse(DateFormat.H().format(DateTime.now()));
  bool showProfileDetails = true;

  late String greet;

  @override
  void initState() {
    super.initState();
    showProfileDetails = false;
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
      body: LocalHeroScope(
        child: Container(
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
          child: Stack(
            children: [
              Column(
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
                        Visibility(
                          visible: !showProfileDetails,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(),
                              onPressed: () async {
                                setState(() {
                                  showProfileDetails = true;
                                });
                              },
                              child: LocalHero(
                                tag: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                  child: const CircleAvatar(
                                    radius: 33,
                                    foregroundImage: AssetImage(
                                        "assets/images/profile.jpeg"),
                                  ),
                                ),
                              ),
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
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 170, 185, 141),
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: DisplayContainer(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              barrierDismissible: true,
                              builder: (context) =>
                                  const ChatScreen(startIndex: 0),
                            ),
                          );
                        },
                        imageAddress: "assets/images/chatgpt_title.png",
                        name: "ChatGPT",
                        desc:
                            "Ask anything and ChatGPT will be\nready to answer and help you",
                        title: "Let's Chat! \nChatGPT"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: DisplayContainer(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => const ChatScreen(
                                  startIndex: 1,
                                ),
                              ));
                        },
                        imageAddress: "assets/images/gemini_logo.svg",
                        name: "Gemini",
                        title: "Start Message!\nGemini",
                        desc:
                            "Ask away! Gemini, ready to answer\nyour questions and assist you."),
                  ),
                ],
              ),
              Visibility(
                visible: showProfileDetails,
                child: Positioned(
                  top: 191,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(70, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(32)),
                        width: MediaQuery.of(context).size.width - 32,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        showProfileDetails = false;
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                            LocalHero(
                              tag: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
                                child: const CircleAvatar(
                                  radius: 100,
                                  foregroundImage: AssetImage(
                                    "assets/images/profile.jpeg",
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
