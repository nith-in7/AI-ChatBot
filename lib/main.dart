import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:ai_chat/firebase_options.dart';
import 'package:ai_chat/model/chat_model.dart';
import 'package:ai_chat/provider/ai_provider.dart';
import 'package:ai_chat/provider/future_list_provider.dart';
import 'package:ai_chat/screens/auth_screen.dart';
import 'package:ai_chat/screens/start_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Open Sans',
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255),
              brightness: Brightness.dark),
          useMaterial3: true),
      title: 'Flutter Demo',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _getAllApi(ref);
            FlutterNativeSplash.remove();
            return const StartScreen();
          } else {
            FlutterNativeSplash.remove();
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

_getAllApi(WidgetRef ref) async {
  final gemApi = await getAPI('gemini_api');
  ref.read(geminiKey.notifier).update((state) => gemApi);

  final chatgptApi = await getAPI('chatgpt');
  ref.read(chatGPTKey.notifier).update((state) => chatgptApi);

  final List<Content> geminiList = await getGeminiHistory();
  ref.read(geminiListProvider.notifier).updateState(geminiList);

  final List<ChatGPTModel> chatgptList = await getChatGPTHistory();
  ref.read(chatGPTListProvider.notifier).updateState(chatgptList);
}
