import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formatted_text/formatted_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ModelText extends StatelessWidget {
  const ModelText({super.key, required this.text, required this.imgAddress});
  final String text;
  final String imgAddress;
  @override
  Widget build(BuildContext context) {
    Widget showLogo = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: SvgPicture.asset(
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        "assets/images/gemini_logo.svg",
        width: 26,
        height: 26,
      ),
    );
    if (imgAddress == "assets/images/chatgpt_title.png") {
      showLogo = CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundImage: AssetImage(imgAddress),
        radius: 20,
      );
    }
    Widget content = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                width: i != 2
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                height: 12,
              )
          ],
        ),
      ),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      constraints: const BoxConstraints(minHeight: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 4, left: 4, top: 12, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color.fromARGB(255, 255, 255, 255)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [showLogo],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: text == ""
                ? content
                : FormattedText(
                    text,
                    formatters: [
                      FormattedTextFormatter(
                          patternChars: '!!!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onError)),
                      const FormattedTextFormatter(
                          patternChars: '**',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      FormattedTextFormatter(
                          patternChars: '```', style: GoogleFonts.spaceMono()),
                      FormattedTextFormatter(
                          patternChars: '`', style: GoogleFonts.spaceMono()),
                    ],
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: text.replaceAll("**", "").replaceAll("```", "")));
                },
                icon: const Icon(
                  Icons.copy,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
