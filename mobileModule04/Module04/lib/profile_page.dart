import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/note_overview.dart';
import 'package:diaryapp/note_screen.dart';
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

  final _scrollController = ScrollController();

  reloadPage() {
    setState(() {});
  }

  deleteNote(MyEntry note) async {
    await EntriesRepository.delete(entry: note);
    reloadPage();
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
            onPressed: () async {
              if (context.mounted) {
                Navigator.pop(context);
              }
              await widget.logout();
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: EntriesRepository.getEntries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              debugPrint(snapshot.data.toString());
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('THE DIARY IS EMPTY'));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error : ${snapshot.error.toString()}'));
              }
              return Scrollbar(
                controller: _scrollController,
                thickness: 8,
                thumbVisibility: true,
                child: ListView(
                padding: const EdgeInsets.all(15),
                controller: _scrollController,
                children: [
                for (MyEntry note in snapshot.data!)
                  GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext cont) {
                              return SimpleDialog(
                                backgroundColor: Colors.red,
                                children: [
                                  NoteOverview(
                                      noteOverviewed: note,
                                      deleteNote: deleteNote,
                                      cred: widget.cred,
                                      reloadPage: reloadPage,
                                      superContext: cont)
                                ],
                              );
                            });
                      },
                      child: ItemNode(entry: note)),
              ]));
            }
            return const SizedBox();
          }),
      bottomNavigationBar: BottomAppBar(
          child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text('New entry',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteScreen(
                            cred: widget.cred,
                            reloadPage: reloadPage,
                          )),
                );
              })),
    );
  }
}
