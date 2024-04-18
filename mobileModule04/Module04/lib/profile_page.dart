import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/item_note.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
    {
      super.key,
      required this.cred,
      required this.logout,
      }
    );

  final Credentials?  cred;
  final Future<void> Function() logout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('${cred?.user.name}'),
      centerTitle: true,
        actions: <Widget>[
    IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.black,
      ),
      onPressed: () {
        logout();
      },
    )
  ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(15),
      children: const [
        ItemNode(),
        ItemNode(),
        ItemNode(),
      ],
    )
    
    
    );
  }
}
