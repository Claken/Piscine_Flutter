import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function(String buttonText) handleButton;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.handleButton,
  });

  getColor(String text) {
    if (text == 'C' || text == 'AC') {
      return Colors.red;
    }
    if (text == '+' || text == '-' || text == '*' || text == '/') {
      return Colors.white;
    }
    if (text == '=') {
      return Colors.greenAccent;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // A rectangular area of a Material that responds to touch.
      splashColor: const Color.fromARGB(
          255, 55, 109, 136), // color of the button when it is touched
      onTap: () {
        if (buttonText != '') {
          handleButton(buttonText);
        }
      },
      child: Ink(
          decoration: BoxDecoration(color: Colors.blueGrey, boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3))
          ]),
          child: Center(
              child: Text(buttonText,
                  style: TextStyle(
                      color: getColor(buttonText),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)))),
    );
  }
}
