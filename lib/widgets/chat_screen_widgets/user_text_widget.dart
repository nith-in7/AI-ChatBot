import 'package:ai_chat/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserText extends ConsumerWidget {
  const UserText({
    super.key,
    required this.value,
    required this.onPressed,
  });
  final String value;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
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
                    value,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: InkWell(
            onTap: () {
              onPressed(value);
            },
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        // IconButton(
        //     style: IconButton.styleFrom(backgroundColor: Colors.red),
        //     onPressed: () {
        //       onPressed(value);
        //     },
        //     icon: const Icon(
        //       Icons.edit_outlined,
        //       color: Colors.white,
        //       size: 20,
        //     ))
      ],
    );
  }
}
