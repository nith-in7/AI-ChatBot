import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final geminiKey = StateProvider<String?>((ref) => null);
final chatGPTKey = StateProvider<String?>((ref) => null);


Future getAPI(String s) async {
  final body =
      await FirebaseFirestore.instance.collection("api_key").doc(s).get();
  return body.data()!['api'];
}
