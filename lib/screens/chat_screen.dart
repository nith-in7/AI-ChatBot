import 'package:ai_chat/widgets/chat_screen_widgets/chatgpt_tab_window.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/gemini_tab_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.startIndex});
  final int startIndex;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int presentIndex;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.startIndex;
    presentIndex = widget.startIndex;
    _tabController.addListener(() {
      setState(() {
        presentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text.rich(TextSpan(children: [
          TextSpan(
              text: "C",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26)),
          TextSpan(
              text: "hat",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: "M",
              style: TextStyle(
                  color: Color.fromARGB(255, 180, 206, 128),
                  fontWeight: FontWeight.bold,
                  fontSize: 26)),
          TextSpan(
              text: "ate",
              style: TextStyle(
                  color: Color.fromARGB(255, 180, 206, 128),
                  fontWeight: FontWeight.bold)),
        ])),
        bottom: TabBar(
            controller: _tabController,
            labelStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: "ChatGPT",
              ),
              Tab(
                text: "Gemini",
              ),
            ]),
        automaticallyImplyLeading: false,
        actions: [
          presentIndex == 0
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Hero(
                    tag: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      foregroundImage:
                          AssetImage("assets/images/chatgpt_title.png"),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Hero(
                    tag: 1,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        fit: BoxFit.cover,
                        width: 27,
                        "assets/images/gemini_logo.svg",
                      ),
                    ),
                  ),
                ),
        ],
        leading: IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              Navigator.pop(context);
            },
            icon: const Icon(
              size: 20,
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 43, 52, 52),
                Color.fromARGB(255, 43, 52, 52),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 48, 48, 47),
                  Color.fromARGB(255, 40, 40, 39)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              width: double.infinity,
              height: double.infinity,
              child: const ChatGPTWindow()),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 43, 52, 52),
                  Color.fromARGB(255, 48, 48, 47),
                  Color.fromARGB(255, 40, 40, 39)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              width: double.infinity,
              height: double.infinity,
              child: const GeminiTabWindow()),
        ],
      ),
    );
  }
}
