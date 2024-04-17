import 'package:diaryapp/item_note.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Profile Page'),
      centerTitle: true,
    ),
    body: ListView(
      padding: const EdgeInsets.all(15),
      children: [
        ItemNode(),
        ItemNode(),
        ItemNode(),
      ],
    )
    
    
    );
  }
}
