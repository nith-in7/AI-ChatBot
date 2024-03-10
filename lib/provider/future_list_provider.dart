import 'package:ai_chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final geminiHistoryProvider = FutureProvider<List<Chat>>
(
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
