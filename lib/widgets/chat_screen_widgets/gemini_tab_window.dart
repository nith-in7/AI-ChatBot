import 'package:ai_chat/model/chat_model.dart';
import 'package:ai_chat/provider/ai_provider.dart';
import 'package:ai_chat/provider/future_list_provider.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/model_text_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/text_field_widget.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/user_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiTabWindow extends ConsumerStatefulWidget {
  const GeminiTabWindow({super.key});

  @override
  ConsumerState<GeminiTabWindow> createState() => _GeminiTabWindowState();
}

Future<String> getGeminiResponse(ref, List<Chat> list, String text) async {
  final apiKey = ref.read(geminiKey).toString();
  final model = GenerativeModel(
      apiKey: apiKey,
      model: "gemini-pro",
      generationConfig: GenerationConfig());

  final chat = model.startChat(
      history: list.map((e) {
    if (e.from == From.model) {
      return Content.model([TextPart(e.text)]);
    } else {
      return Content.text(e.text);
    }
  }).toList());

  final content = Content.text(text);
  final respose = await chat.sendMessage(content);
  return respose.text!;
}

class _GeminiTabWindowState extends ConsumerState<GeminiTabWindow> {
  @override
  Widget build(BuildContext context) {
    List<Chat> list = ref.read(geminiHistoryProvider).when(
          data: (data) => data,
          error: (error, stackTrace) => [],
          loading: () => [],
        );
    final list1 = list.reversed.toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: list1.length,
            itemBuilder: (context, index) {
              if (list1[index].from == From.user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: UserText(text: list1[index].text),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
                child: ModelText(text: list1[index].text),
              );
            },
          ),
        ),
        TextFieldWidget(
            enableButton: list.isNotEmpty ? list.last.from == From.model : true,
            onPressed: (String text) async {
              setState(() {
                list.add(Chat(from: From.user, text: text));
              });
              final res = await getGeminiResponse(
                  ref, list.sublist(0, list.length - 1), text);
              setState(() {
                list.add(Chat(from: From.model, text: res));
              });
            })
      ],
    );
  }
}
