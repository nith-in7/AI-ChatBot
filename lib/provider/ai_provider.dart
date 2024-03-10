import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = FutureProvider(
  (ref) {
    return getAPI();
  },
);

final geminiKey = StateProvider<String?>((ref) => null);

getAPI() async {
  final body = await FirebaseFirestore.instance
      .collection("api_key")
      .doc("gemini_api")
      .get();
  return body.data()!['api'];
}