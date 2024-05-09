import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/feeling.dart';
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

  double getPercentage(String feel, List<MyEntry> entries) {
    int total = entries.length;
    int nbr = 0;
    for (MyEntry note in entries) {
      if (note.feeling == feel) {
        nbr++;
      }
    }
    return (nbr / total) * 100;
  }

  Widget feelContainer(String feel, List<MyEntry> entries) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Row(children: [
          Icon(
            emojiMap[feel],
            size: 30,
            color: colorMap[feel],
          ),
          const SizedBox(
            width: 30,
          ),
          Text("${getPercentage(feel, entries).round().toString()}%")
        ]));
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
                              child: Text(snapshot.data!.isEmpty
                                  ? "Diary empty : no feel"
                                  : "The feel list of your ${snapshot.data!.length} ${snapshot.data!.length == 1 ? "entry" : "entries"}")),
                          feelContainer('Happy', snapshot.data!),
                          feelContainer('Satisfied', snapshot.data!),
                          feelContainer('Normal', snapshot.data!),
                          feelContainer('Sad', snapshot.data!),
                          feelContainer('Angry', snapshot.data!),
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
