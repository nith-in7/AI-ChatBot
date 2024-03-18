import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class ChatGPTModel {
  ChatGPTModel({required this.role, required this.content});
  final Role role;
  final List<String> content;
}

enum Role { user, assistant }

const uuid = Uuid();

class ListOfGeminiChat {
  ListOfGeminiChat({required this.chatList}) : id = uuid.v4();
  final String id;
  final List<Content> chatList;
}
