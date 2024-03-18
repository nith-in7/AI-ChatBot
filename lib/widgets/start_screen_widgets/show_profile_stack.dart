import 'dart:ui';

import 'package:ai_chat/widgets/start_screen_widgets/profile_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_hero/local_hero.dart';

class ShowProfileStack extends StatelessWidget {
  const ShowProfileStack(
      {super.key,
      required this.networkImage,
      required this.user,
      required this.onPressed});
  final CachedNetworkImageProvider networkImage;
  final User user;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(
          
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color.fromARGB(41, 0, 0, 0),
              border: Border.all(
                  width: 1, color: const Color.fromARGB(70, 255, 255, 255)),
              borderRadius: BorderRadius.circular(32)),
          width: MediaQuery.of(context).size.width - 32,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  LocalHero(
                    
                    tag: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 88,
                        foregroundImage: networkImage,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ProfileDetails(name: "Name", value: user.displayName!),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileDetails(name: "Email", value: user.email!),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton.icon(
                      onPressed: FirebaseAuth.instance.signOut,
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
