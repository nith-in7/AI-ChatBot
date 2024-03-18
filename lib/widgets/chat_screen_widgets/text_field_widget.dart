import 'dart:ui';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.onPressed,
      required this.enableButton,
      required this.textController,
      required this.isDisableButton});
  final bool enableButton;
  final bool isDisableButton;
  final TextEditingController textController;
  final void Function(String text) onPressed;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = widget.textController;

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  controller: textController,
                  minLines: 1,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(130, 0, 0, 0),
                    contentPadding:
                        EdgeInsets.only(bottom: 60 / 2, right: 20, left: 20),
                    hintText: "Send a message...",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(145, 255, 255, 255)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(130, 0, 0, 0),
              ),
              child: IconButton(
                disabledColor: const Color.fromARGB(49, 255, 255, 255),
                onPressed: widget.enableButton
                    ? !widget.isDisableButton
                        ? () {
                            widget.onPressed(textController.text.trim());
                            textController.clear();
                            setState(() {
                              // widget.isDisableButton = true;
                            });
                          }
                        : null
                    : null,
                icon: Icon(
                  Icons.send_rounded,
                  color: widget.enableButton
                      ? widget.isDisableButton
                          ? null
                          : Colors.white
                      : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
