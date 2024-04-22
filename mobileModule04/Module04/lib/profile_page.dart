import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/note_screen.dart';
import 'package:diaryapp/item_note.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  bool _noteOverview = false;
  MyEntry? _noteOverviewed;
  final _scrollController = ScrollController();

  reloadPage() {
    setState(() {});
  }

  changeNoteOverview(bool currentState, MyEntry? currentNote) {
    setState(() {
      _noteOverview = currentState;
      _noteOverviewed = currentNote;
    });
  }

  deleteNote() async {
    await EntriesRepository.delete(entry: _noteOverviewed!);
    changeNoteOverview(false, null);
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
            onPressed: () {
              widget.logout();
            },
          )
        ],
      ),
      body: Stack(children: [
        FutureBuilder(
            future: EntriesRepository.getEntries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData == false) {
                  return const Center(child: Text('Empty'));
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                return ListView(padding: const EdgeInsets.all(15), children: [
                  for (MyEntry note in snapshot.data!)
                    GestureDetector(
                        onTap: () {
                          changeNoteOverview(true, note);
                        },
                        child: ItemNode(entry: note)),
                ]);
              }
              return const SizedBox();
            }),
        _noteOverview
            ? Positioned(
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white),
                        width: 300.0,
                        height: 400.0,
                        child: Column(
                          children: [
                            Text(DateFormat(
                                    DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                                .format(_noteOverviewed?.date ??
                                    DateTime.timestamp())),
                            const Divider(
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '     My feeling : ${_noteOverviewed?.feeling}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                            const Divider(
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Text(
                                    '${_noteOverviewed?.content}',
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content:
                                                  const Text('Are you sure ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await deleteNote();
                                                    },
                                                    child: const Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'No');
                                                    },
                                                    child: const Text('No'))
                                              ],
                                            ));
                                  },
                                  child: const Text('Delete This Entry'),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NoteScreen(
                                                cred: widget.cred,
                                                reloadPage: reloadPage,
                                                entry: _noteOverviewed,
                                              )),
                                    );
                                  },
                                  child: const Text('Update This Entry'),
                                ),
                              ],
                            )),
                            TextButton(
                              onPressed: () {
                                changeNoteOverview(false, null);
                              },
                              child: const Text(
                                'Close ',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ))))
            : const SizedBox()
      ]),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add, color: Colors.white,),
          label: const Text('New entry', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteScreen(
                        cred: widget.cred,
                        reloadPage: reloadPage,
                      )),
            );
          }),
    );
  }
}
