import 'package:flutter/material.dart';

class BuildResetButton extends StatelessWidget {
  const BuildResetButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed});

  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            side: const BorderSide(color: Colors.white60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ));
  }
}
