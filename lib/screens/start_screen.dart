import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:local_hero/local_hero.dart';

import 'package:ai_chat/provider/image_provider.dart';
import 'package:ai_chat/screens/chat_screen.dart';
import 'package:ai_chat/widgets/start_screen_widgets/display_container.dart';
import 'package:ai_chat/widgets/start_screen_widgets/show_profile_stack.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen>
    with SingleTickerProviderStateMixin {
  final User user = FirebaseAuth.instance.currentUser!;

  int time = int.parse(DateFormat.H().format(DateTime.now()));
  bool showProfileDetails = false;

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
    var networkImage = ref.read(profileImageProvider);
    return Scaffold(
      body: LocalHeroScope(
        duration: const Duration(milliseconds: 230),
        child: Container(
          height: MediaQuery.of(context).size.height,
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
              SingleChildScrollView(
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
                                    child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 33,
                                        foregroundImage: networkImage),
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
                      height: 68,
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
                            TyperAnimatedText(
                                user.displayName == null
                                    ? ""
                                    : user.displayName!,
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
                    DisplayContainer(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) =>
                                  const ChatScreen(startIndex: 0),
                            ),
                          );
                        },
                        imageAddress: "assets/images/ChatGPT.svg",
                        name: "ChatGPT",
                        desc:
                            "Ask anything and ChatGPT will be\nready to answer and help you",
                        title: "Let's Chat! \nChatGPT"),
                    const SizedBox(
                      height: 20,
                    ),
                    DisplayContainer(
                        onPressed: () async {
                          await Navigator.push(
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
                  ],
                ),
              ),
              Visibility(
                visible: showProfileDetails,
                child: Positioned(
                  top: 185,
                  bottom: 0,
                  child: ShowProfileStack(
                    networkImage: networkImage,
                    user: user,
                    onPressed: () {
                      setState(
                        () {
                          showProfileDetails = false;
                        },
                      );
                    },
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
