import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/models/feeling.dart';
import 'package:diaryapp/note_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteOverview extends StatelessWidget {
  NoteOverview({
    super.key,
    required this.noteOverviewed,
    required this.deleteNote,
    required this.cred,
    required this.reloadPage,
    required this.superContext,
  });

  final MyEntry noteOverviewed;
  final Function(MyEntry note) deleteNote;
  final Credentials? cred;
  final Function reloadPage;
  final BuildContext superContext;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                // border: Border.all(color: Colors.black),
                color: Colors.white),
            width: 300.0,
            height: 420.0,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(noteOverviewed.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                    .format(noteOverviewed.date)),
                const Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(emojiMap[noteOverviewed.feeling],
                          color: colorMap[noteOverviewed.feeling]),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        noteOverviewed.feeling,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ]),
                const Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            noteOverviewed.content,
                          ),
                        ),
                      )),
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
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: const Text('Do you really want to delete this entry ?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await deleteNote(noteOverviewed);
                                          if (context.mounted) {
                                            Navigator.pop(context, 'Yes');
                                            if (superContext.mounted) {
                                              Navigator.pop(superContext);
                                            }
                                          }
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'No');
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
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteScreen(
                                    cred: cred,
                                    reloadPage: reloadPage,
                                    entry: noteOverviewed,
                                  )),
                        );
                      },
                      child: const Text('Update This Entry'),
                    ),
                  ],
                )),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Close');
                  },
                  child: const Text(
                    'Close ',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            )));
  }
}
