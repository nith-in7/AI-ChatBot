import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:ai_chat/provider/ai_provider.dart';
import 'package:ai_chat/provider/future_list_provider.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/model_text_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/text_field_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/user_text_widget.dart';

class GeminiTabWindow extends ConsumerStatefulWidget {
  const GeminiTabWindow({super.key});

  @override
  ConsumerState<GeminiTabWindow> createState() => _GeminiTabWindowState();
}

class _GeminiTabWindowState extends ConsumerState<GeminiTabWindow> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late TextEditingController textController;
  bool isDisableButton = true;
  bool allow = true;

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

  getGeminiResponse(WidgetRef ref, List<Content> list, String text) async {
    final apiKey = ref.read(geminiKey).toString();
    final chatList = ref.watch(geminiListProvider.notifier);
    try {
      final model = GenerativeModel(
          apiKey: apiKey,
          model: "gemini-pro",
          generationConfig: GenerationConfig());

      final chat = model.startChat(history: list);

      final content = Content.text(text);

      final respose = chat.sendMessageStream(content);
      await for (final item in respose) {
        chatList.updateLastChat(item.text!);
      }
    } on GenerativeAIException catch (e) {
      chatList.updateLastChat(
        e.message,
      );
    } finally {
      ref.read(geminiListProvider).last.parts.removeAt(0);
      if (ref.read(geminiListProvider).last.parts.isEmpty) {
        chatList.updateLastChat("Unale to generate response.");
      }
      FirebaseFirestore.instance
          .collection(currentUser.uid)
          .doc("chat")
          .collection("gemini")
          .doc()
          .set({
        'role': 'model',
        'content': ref
            .read(geminiListProvider)
            .last
            .parts
            .whereType<TextPart>()
            .map((e) => e.text)
            .join(),
        "createdAt": Timestamp.now()
      });
      setState(
        () {
          allow = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(geminiListProvider);
    final list1 = list.reversed.toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: list1.length,
            itemBuilder: (context, index) {
              if (list1[index].role == 'user') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: UserText(
                    value: list1[index]
                        .parts
                        .whereType<TextPart>()
                        .map((e) => e.text)
                        .join(''),
                    onPressed: (String text) {
                      textController.text = text;
                    },
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
                child: ModelText(
                  text: list1[index]
                      .parts
                      .whereType<TextPart>()
                      .map((e) => e.text)
                      .join(''),
                  imgAddress: "assets/images/gemini_logo.svg",
                ),
              );
            },
          ),
        ),
        TextFieldWidget(
          isDisableButton: isDisableButton,
          textController: textController,
          enableButton: allow,
          onPressed: (String text) {
            FirebaseFirestore.instance
                .collection(currentUser.uid)
                .doc("chat")
                .collection("gemini")
                .doc()
                .set({
              'role': 'user',
              'content': text,
              "createdAt": Timestamp.now()
            });
            final listRef = ref.read(geminiListProvider.notifier);
            listRef.addNewChat(Content('user', [TextPart(text)]));
            setState(() {
              allow = false;
            });
            listRef.addNewChat(Content('model', [TextPart("")]));

            final a = ref.read(geminiListProvider);
            getGeminiResponse(ref, a.sublist(0, a.length - 2), text);
          },
        )
      ],
    );
  }
}
