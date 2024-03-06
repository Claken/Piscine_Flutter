import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String userInput;
  final String result;

  const TextFields({
    super.key,
    required this.userInput,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: MediaQuery.of(context).size.height / 3,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(userInput,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
              )),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        // const Divider(color: Colors.white,)
      ],
    ));
  }
}
