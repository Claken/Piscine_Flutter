import 'dart:io';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/feeling.dart';
import 'package:diaryapp/note_overview.dart';
import 'package:diaryapp/note_screen.dart';
import 'package:diaryapp/item_note.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  int _nbr = 0;

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
        toolbarHeight: 100,
        backgroundColor: Colors.red,
        title: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(widget.cred?.user.pictureUrl.toString() ?? '',
                width: 80),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            "${widget.cred?.user.name}",
            style: const TextStyle(color: Colors.white),
          ),
        ]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await widget.logout();
            },
          )
        ],
      ),
      body: Column(children: [
        Container(
            height: 190,
            width: 500,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: FutureBuilder(
                future: EntriesRepository.getEntries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('THE DIARY IS EMPTY'));
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('Error : ${snapshot.error.toString()}'));
                    }
                    return Scrollbar(
                        controller: _scrollController,
                        thickness: 8,
                        thumbVisibility: true,
                        child: ListView(
                            padding: const EdgeInsets.all(15),
                            controller: _scrollController,
                            reverse: true,
                            children: [
                              for (MyEntry note in snapshot.data!.getRange(
                                  snapshot.data!.length - 2 < 0
                                      ? 0
                                      : snapshot.data!.length - 2,
                                  snapshot.data!.length))
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
                })),
        Container(
            height: 190,
            width: 500,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: FutureBuilder(
                future: EntriesRepository.getEntries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                                  "Your feel for your ${snapshot.data!.length} entries")),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              emojiMap["Happy"],
                              size: 30,
                              color: colorMap["Happy"],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              emojiMap["Satisfied"],
                              size: 30,
                              color: colorMap["Satisfied"],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              emojiMap["Normal"],
                              size: 30,
                              color: colorMap["Normal"],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              emojiMap["Sad"],
                              size: 30,
                              color: colorMap["Sad"],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              emojiMap["Angry"],
                              size: 30,
                              color: colorMap["Angry"],
                            ),
                          ),
                        ]);
                  }
                  return const SizedBox();
                })),
        FloatingActionButton.extended(
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label:
                const Text('New entry', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteScreen(
                          cred: widget.cred,
                          reloadPage: reloadPage,
                        )),
              );
            })
      ]),
    );
  }
}
