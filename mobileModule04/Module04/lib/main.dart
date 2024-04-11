import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
const appScheme = 'diaryapp';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------

class Profile extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const Profile(this.logoutAction, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Name: ${user?.name}'),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () async {
            await logoutAction();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------

class Login extends StatelessWidget {
  final Future<void> Function() loginAction;
  final String? loginError;

  const Login(this.loginAction, this.loginError, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            await loginAction();
          },
          child: const Text('Login'),
        ),
        Text(loginError ?? ''),
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _MyAppState extends State<MyApp> {
  Credentials? _credentials;
  late Auth0 auth0;

  bool isBusy = false;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(home:
    Scaffold(
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
            ]))));
  }
  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials = await auth0.webAuthentication(scheme: appScheme).login();

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

  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: appScheme).logout();

    setState(() {
      _credentials = null;
    });
  }

  @override
  void initState() {
    super.initState();

    auth0 = Auth0('dev-zcqf4g3uweedwi8f.us.auth0.com', 'JFNDQYx5JmGVaLChFJ7zekqk4pYOKtpI');
    errorMessage = '';
  }
}