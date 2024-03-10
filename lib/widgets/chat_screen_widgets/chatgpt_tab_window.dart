import 'package:ai_chat/provider/ai_provider.dart';
import 'package:ai_chat/widgets/chat_screen_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatGPTWindow extends ConsumerStatefulWidget {
  const ChatGPTWindow({super.key});

  @override
  ConsumerState<ChatGPTWindow> createState() => _ChatGPTWindowState();
}

class _ChatGPTWindowState extends ConsumerState<ChatGPTWindow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: Text(ref.read(geminiKey).toString())),
        TextFieldWidget(
          enableButton: false,
          onPressed: (text) {},
        ),
      ],
    );
  }
}
