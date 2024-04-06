import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  bool _isToggle = false;
  bool _isBusy = false;
  late String errorMessage;

  void _toggleButton() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/book-with-yellow-cover.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Center(
                  child: Text('WELCOME TO YOUR\nDIARY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.brown
                      ))),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: const BorderSide(width: 1, color: Colors.green),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () {
                  _toggleButton();
                },
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              )
            ])));
  }
}
