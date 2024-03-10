import 'package:ai_chat/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserText extends ConsumerWidget {
  const UserText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context, ref) {
    return Row(
      
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 18,
              foregroundImage: ref.read(profileImageProvider),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  text,
                  maxLines: null,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
