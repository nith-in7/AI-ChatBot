import 'dart:ui';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.onPressed,
    required this.enableButton,
  });
  final bool enableButton;
  final void Function(String text) onPressed;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController textController;
  bool isDisableButton = true;

  @override
  void initState() {
    textController = TextEditingController();
    isDisableButton = textController.text.trim().isEmpty;
    super.initState();
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
                    setState(() {
                      isDisableButton = textController.text.trim().isEmpty;
                    });
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
                      ? !isDisableButton
                          ? () {
                              widget.onPressed(textController.text.trim());
                              textController.clear();
                              setState(() {
                                isDisableButton = true;
                              });
                            }
                          : null
                      :  null,
                  icon: Icon(
                    Icons.send_rounded,
                    color: widget.enableButton
                        ? isDisableButton
                            ? null
                            : Colors.white
                        : null,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
