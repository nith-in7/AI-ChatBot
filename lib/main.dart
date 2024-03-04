
import 'package:ai_chat/screens/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            pageTransitionsTheme:  const PageTransitionsTheme(builders: {
              TargetPlatform.android:  CupertinoPageTransitionsBuilder()
            }),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
        home: const StartScreen());
  }
}
