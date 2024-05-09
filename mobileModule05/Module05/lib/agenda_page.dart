import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/item_note.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/note_overview.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda extends StatefulWidget {
  const Agenda({
    super.key,
    required this.cred,
  });

  final Credentials? cred;

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  var _focusedDay = DateTime.now();
  var _selectedDay = DateTime.now();
  final _firstDay = DateTime(DateTime.now().year, DateTime.now().month , 1);
  final _lastDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  final _controller = ScrollController();

  void reloadPage() {
    setState(() {});
  }

  deleteNote(MyEntry note) async {
    await EntriesRepository.delete(entry: note);
    reloadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TableCalendar(
        pageJumpingEnabled: true,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        locale: 'en_US',
        onDaySelected: (selectedDay, focusedDay) => setState(() {
          _focusedDay = focusedDay;
          _selectedDay = selectedDay;
        }),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 128, 121),
              shape: BoxShape.circle),
          selectedDecoration:
              BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),

      ),
        Expanded(
          child:
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pinkAccent, width: 2),
            ),
            child: FutureBuilder(
          future: EntriesRepository.getEntriesByDate(DateUtils.dateOnly(_selectedDay)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('NO ENTRY AT THIS DATE'));
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error : ${snapshot.error.toString()}'));
              }
              return Scrollbar(
                  controller: _controller,
                  thickness: 8,
                  thumbVisibility: true,
                  child: ListView(
                      padding: const EdgeInsets.all(15),
                      controller: _controller,
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
            return const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ));
          }))),
    ]);
  }
}
