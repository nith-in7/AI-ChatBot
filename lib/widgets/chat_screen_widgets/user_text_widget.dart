import 'package:ai_chat/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserText extends ConsumerWidget {
  const UserText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 18,
                  foregroundImage: ref.read(profileImageProvider),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
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
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 24,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
