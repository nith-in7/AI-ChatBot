import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:ai_chat/model/chat_model.dart';

// ---------------------------Gemini---------------------------------------

Future<List<Content>> getGeminiHistory() async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  final defaultPath =
      db.collection(currentUser.uid).doc("chat").collection("gemini");
  final lastQueary =
      await defaultPath.orderBy("createdAt", descending: true).limit(1).get();
  final last = lastQueary.docs.first;
  if (last.data()['role'] == 'user') {
    await defaultPath.doc(last.id).delete();
  }
  final response = await defaultPath.orderBy("createdAt").get();

  final List<Content> chatList = response.docs.map((e) {
    return Content(e.data()['role'], [TextPart(e.data()["content"])]);
  }).toList();
  return chatList;
}

class GeminiListNotifier extends StateNotifier<List<Content>> {
  GeminiListNotifier(super.state);

  void addNewChat(Content chat) {
    state = [...state, chat];
  }

  void updateLastChat(String text) {
    final last = state.last;
    final con = Content(last.role, [...last.parts, TextPart(text)]);
    state = [...state.sublist(0, state.length - 1), con];
  }

  void updateState(List<Content> list) {
    state = list;
  }
}

final geminiListProvider =
    StateNotifierProvider<GeminiListNotifier, List<Content>>((ref) {
  return GeminiListNotifier([]);
});

// ---------------------------ChatGPT---------------------------------------

Future<List<ChatGPTModel>> getChatGPTHistory() async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  final defaultPath =
      db.collection(currentUser.uid).doc("chat").collection("chatgpt");
  final lastQuery =
      await defaultPath.orderBy('createdAt', descending: true).limit(1).get();
  final last = lastQuery.docs.first;
  if (last.data()['role'] == 'user') {
    defaultPath.doc(last.id).delete();
  }
  final response = await defaultPath.orderBy("creatgoedAt").get();

  final List<ChatGPTModel> chatList = response.docs.map((e) {
    return ChatGPTModel(
        role: e.data()['role'] == "user" ? Role.user : Role.assistant,
        content: [e.data()['content']]);
  }).toList();

  return chatList;
}

class ChatGPTListNotifiier extends StateNotifier<List<ChatGPTModel>> {
  ChatGPTListNotifiier(super.state);

  void addNewChat(ChatGPTModel chat) {
    state = [...state, chat];
  }

  void updateLastChat(String text) {
    final last = state.last;
    final con = ChatGPTModel(role: last.role, content: [text]);
    state = [...state.sublist(0, state.length - 1), con];
  }

  void updateState(List<ChatGPTModel> list) {
    state = list;
  }
}

final chatGPTListProvider =
    StateNotifierProvider<ChatGPTListNotifiier, List<ChatGPTModel>>((ref) {
  return ChatGPTListNotifiier([]);
});

final authScreenLoading = StateProvider((ref) => false);
