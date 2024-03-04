import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height / 4.2,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(32)),
                      width: MediaQuery.of(context).size.width - 32,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context,false);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 30,
                                  ))
                            ],
                          ),
                          const Hero(
                            tag: 3,
                            child: CircleAvatar(
                              radius: 103,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 100,
                                foregroundImage:
                                    AssetImage("assets/images/profile.jpeg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
