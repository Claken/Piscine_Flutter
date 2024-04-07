import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
const   appScheme = "diary_app";

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  bool _isToggle = false;
  bool _isBusy = false;
  Credentials? _credentials;
  late Auth0 auth0;
  late String errorMessage;

  Future<void> loginAction() async {
    setState(() {
      _isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: appScheme).login();

      setState(() {
        _isBusy = false;
        _credentials = credentials;
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        _isBusy = false;
        errorMessage = e.toString();
      });
    }
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
                          backgroundColor: Colors.brown))),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: const BorderSide(width: 1, color: Colors.green),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () {
                  loginAction();
                },
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ])));
  }
}
