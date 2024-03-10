import 'package:ai_chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final quextionProvider = StateProvider((ref) => "");

final geminiHistoryProvider = FutureProvider<List<Chat>>(
  (ref) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final List<Chat> list = [];
    FirebaseFirestore.instance
        .collection(currentUser.uid)
        .doc("gemini")
        .get()
        .then(
      (value) {
        return list.add(
          Chat(
            from: value.data()!['from'],
            text: value.data()!['text'],
          ),
        );
      },
    );
    return list;
  },
);

class ChatListNotifiier extends StateNotifier<List<Content>> {
  ChatListNotifiier() : super([]);

  void addNewChat(Content chat) {
    state = [...state, chat];
  }

  void updateLastChat(String text) {
    final last = state.last;
    final con = Content(last.role, [...last.parts, TextPart(text)]);
    state = [...state.sublist(0, state.length - 1), con];
  }
}

final chatListProvider =
    StateNotifierProvider<ChatListNotifiier, List<Content>>(
        (ref) => ChatListNotifiier());
