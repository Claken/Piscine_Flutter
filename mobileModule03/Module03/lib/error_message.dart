import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(color: Colors.red, border: Border.all(color: Colors.red)),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )));
  }
}
