import 'package:flutter/material.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  bool _isToggle = false;

  void _toggleButton() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/book-with-yellow-cover.jpg"),
            fit: BoxFit.cover,
          ),
        ),
  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(
          child: Center(
              child: Text('WELCOME TO YOUR DIARY',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                  )))),
      ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          side: const BorderSide(width: 1, color: Colors.green),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () {
          _toggleButton();
        },
        child: const Text('Login', style: TextStyle(color: Colors.white)),
      )
    ]));
  }
}
