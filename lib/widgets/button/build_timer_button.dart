import 'package:flutter/material.dart';

class BuildTimerButton extends StatelessWidget {
  const BuildTimerButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.buttonColor,
      required this.onPressedStart,
      required this.onPressedStop});

  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressedStart;
  final VoidCallback onPressedStop;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            side: const BorderSide(color: Colors.white60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        onPressed: () {
          onPressedStop();
          onPressedStart();
        },
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ));
  }
}