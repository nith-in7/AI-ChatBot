import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisplayContainer extends StatelessWidget {
  const DisplayContainer(
      {super.key,
      required this.title,
      required this.desc,
      required this.name,
      required this.imageAddress,
      required this.onPressed});

  final String title;
  final String desc;
  final String name;
  final String imageAddress;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    late Widget image;
    if (imageAddress == "assets/images/gemini_logo.svg") {
      image = Hero(
        tag: 1,
        child: CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            imageAddress,
            width: 44,
            height: 44,
          ),
        ),
      );
    } else {
      image = const Hero(
        tag: 0,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          foregroundImage: AssetImage("assets/images/chatgpt_title.png"),
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(40, 253, 253, 253),
        border: Border.all(
            color: const Color.fromARGB(195, 125, 123, 123), width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Open Sans'),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8), child: image)
                    // child:
                  ],
                ),
                Text(
                  desc,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(185, 255, 255, 255),
                    fontFamily: 'Open Sans',
                  ),
                ),
                Container(
                  width: 175,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(width: 2))),
                    onPressed: onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Start $name",
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Open sans",
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
