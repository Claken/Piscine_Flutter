import 'package:flutter/material.dart';

class APage extends StatelessWidget {
  const APage({
    super.key,
    required this.textOne,
    required this.textTwo,
  });

  final String textOne;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textOne,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(textTwo.length > 15 ? '${textTwo.substring(0, 10)}...' : textTwo,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 20)),
        ]);
  }
}
