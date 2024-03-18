import 'package:ai_chat/model/chat_model.dart';
import 'package:ai_chat/provider/ai_provider.dart';
import 'package:ai_chat/provider/future_list_provider.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/model_text_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/text_field_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/user_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatGPTWindow extends ConsumerStatefulWidget {
  const ChatGPTWindow({super.key});

  @override
  ConsumerState<ChatGPTWindow> createState() => _ChatGPTWindowState();
}

class _ChatGPTWindowState extends ConsumerState<ChatGPTWindow> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool allow = true;
  bool isDisableButton = true;
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    textController.addListener(() {
      setState(() {
        isDisableButton = textController.text.trim().isEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatList = ref.watch(chatGPTListProvider);
    final List<ChatGPTModel> reveList = chatList.reversed.toList();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: ListView.builder(
          reverse: true,
          itemCount: reveList.length,
          itemBuilder: (context, index) {
            if (reveList[index].role == Role.user) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: UserText(
                    value: reveList[index].content.first,
                    onPressed: (String text) {
                      textController.text = text;
                    }),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
                child: ModelText(
                  text: reveList[index].content.join(),
                  imgAddress: "assets/images/chatgpt_title.png",
                ),
              );
            }
          },
        )),
        TextFieldWidget(
          isDisableButton: isDisableButton,
          textController: textController,
          enableButton: allow,
          onPressed: (String text) async {
            FirebaseFirestore.instance
                .collection(currentUser.uid)
                .doc("chat")
                .collection("chatgpt")
                .doc()
                .set({
              'role': 'user',
              'content': text,
              "createdAt": Timestamp.now()
            });
            final listRef = ref.watch(chatGPTListProvider.notifier);
            listRef.addNewChat(ChatGPTModel(role: Role.user, content: [text]));
            setState(() {
              allow = false;
            });
            listRef
                .addNewChat(ChatGPTModel(role: Role.assistant, content: [""]));

            final a = ref.read(chatGPTListProvider);
            final res = await getChatGPTResponse(
              ref,
              a.sublist(0, a.length - 1),
            );
            FirebaseFirestore.instance
                .collection(currentUser.uid)
                .doc("chat")
                .collection("chatgpt")
                .doc()
                .set({
              'role': 'assistant',
              'content': res,
              "createdAt": Timestamp.now()
            });
            listRef.updateLastChat(res);
            setState(() {
              allow = true;
            });
          },
        ),
      ],
    );
  }
}

Future<String> getChatGPTResponse(
    WidgetRef ref, List<ChatGPTModel> chatList) async {
  final api = ref.read(chatGPTKey);

  final dio = Dio();
  final message = chatList
      .map(
        (e) => {"role": e.role.name, "content": e.content.first},
      )
      .toList();

  final Response response = await dio.post(
    "https://api.anthropic.com/v1/messages",
    data: {
      "model": "claude-3-opus-20240229",
      "messages": [...message],
      "max_tokens": 256,
      // "stream": true
    },
    options: Options(
      // responseType: ResponseType.stream,
      headers: {
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
        "x-api-key": api
      },
    ),
  );

  return response.data["content"][0]["text"];
}
















      // final  res = await http.StreamedRequest(
      //   'POST',
      //   Uri.parse("https://api.anthropic.com/v1/messages")

      // headers: {
      //   "anthropic-version": "2023-06-01",
      //   "anthropic-beta": "messages-2023-12-15",
      //   "content-type": "application/json",
      //   "x-api-key": api
      // },
      // body: jsonEncode(
      //   {
      //     "model": "claude-3-opus-20240229",
      //     "messages": [
      //       {"role": "user", "content": "Hello!"}
      //     ],
      //     "max_tokens": 256,
      //     "streams": true
      //   },
      // ),

      //       final l = [];
      //       bool got = false;
      //       await for (final i in response.data.stream) {
      //         final j = utf8.decode(i);
      //         // print(j);
      //         final g = j.indexOf('"content_block_delta"');
      //         final f = j.lastIndexOf("}}");
      //         print("$g and $f");
      //         if (g == -1 || f == -1) {
      //           continue;
      //         }
      //         print(j);
      //         final h = j.substring(g, f).trim();
      //         print("%%%% $h");
      //         l.add(h);

      // final mes = jsonDecode("{${j.replaceFirst("\n", ",")}}");
      // final mes=jsonDecode(j);
      // print(g);
    