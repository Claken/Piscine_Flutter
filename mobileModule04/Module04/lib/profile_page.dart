import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/add_note.dart';
import 'package:diaryapp/item_note.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.cred,
    required this.logout,
  });

  final Credentials? cred;
  final Future<void> Function() logout;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cred?.user.name}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              widget.logout();
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: EntriesRepository.getEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData == false) {
                return const Center(child: Text('Empty'));
            }
            if (snapshot.hasError) {
                return const Center(child: Text('Error'));
            }
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                for (MyEntry note in snapshot.data!) ItemNode(entry: note),
              ]
            );
          }
          return const SizedBox();
        }
        
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('New entry'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNoteScreen(
                cred: widget.cred,
                reloadPage: reloadPage,
                )),
            );
          }),
    );
  }
}
