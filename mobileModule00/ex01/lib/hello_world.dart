import 'package:flutter/material.dart';

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  bool _isToggle = false;

  void _toggleButton() {
    setState(() {
      _isToggle = _isToggle ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(), color: Colors.grey),
          child: Text(_isToggle ? "Hello World" : "A Simple Text",
              style: const TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(height: 5),
      ElevatedButton(
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.grey),
          padding: const EdgeInsets.all(10),
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          _toggleButton();
        },
        child: const Text('click here'),
      )
    ]);
  }
}
