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

class _GeminiTabWindowState extends ConsumerState<GeminiTabWindow> {
  getGeminiResponse(WidgetRef ref, List<Content> list, String text) async {
    final apiKey = ref.read(geminiKey).toString();
    final model = GenerativeModel(
        apiKey: apiKey,
        model: "gemini-pro",
        generationConfig: GenerationConfig());

    final chat = model.startChat(history: list);

    final content = Content.text(text);
    final respose = chat.sendMessageStream(content);
    await for (final item in respose) {
      ref.watch(chatListProvider.notifier).updateLastChat(item.text!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(chatListProvider);
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
                      text: list1[index]
                          .parts
                          .whereType<TextPart>()
                          .map((e) => e.text)
                          .join('')),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
                child: ModelText(
                    text: list1[index]
                        .parts
                        .whereType<TextPart>()
                        .map((e) => e.text)
                        .join('')),
              );
            },
          ),
        ),
        TextFieldWidget(
            enableButton: list.isNotEmpty ? list.last.role == 'model' : true,
            onPressed: (String text) {
              ref.read(textProvider.notifier).update((state) => text);
              final listRef = ref.watch(chatListProvider.notifier);
              listRef.addNewChat(Content('user', [TextPart(text)]));
              listRef.addNewChat(Content('model', [TextPart("")]));

              final a = ref.read(chatListProvider);
              getGeminiResponse(ref, a.sublist(0, a.length - 2), text);
            })
      ],
    );
  }
}
