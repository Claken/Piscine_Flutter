import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

const appScheme = 'diaryapp';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _MyDiaryState();
}

class _MyDiaryState extends State<Diary> {
  Credentials? _credentials;
  late Auth0 auth0;

  bool isBusy = false;
  late String errorMessage;

  @override
  void initState() {
    super.initState();

    auth0 = Auth0('dev-zcqf4g3uweedwi8f.us.auth0.com',
        'JFNDQYx5JmGVaLChFJ7zekqk4pYOKtpI');
    errorMessage = '';
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: appScheme).login();

      setState(() {
        isBusy = false;
        _credentials = credentials;
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isBusy
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("assets/images/book-with-yellow-cover.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          if (_credentials == null) {
                            loginAction();
                          }
                        },
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ])));
  }
}
