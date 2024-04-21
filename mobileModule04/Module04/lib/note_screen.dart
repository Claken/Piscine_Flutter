import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
    required this.cred,
    required this.reloadPage,
    this.entry,
  });

  final Credentials? cred;
  final Function reloadPage;
  final MyEntry? entry;

  @override
  State<NoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<NoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.entry != null) {
      _title.text = widget.entry!.title;
      _description.text = widget.entry!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.entry == null ? 'Add note' : 'Update note'), actions: [
          widget.entry == null
              ? IconButton(
                  onPressed: () async {
                    await _insertEntry();
                    widget.reloadPage();
                  },
                  icon: const Icon(Icons.done))
              : IconButton(
                  onPressed: () async {
                    await _updateEntry();
                    widget.reloadPage();
                  },
                  icon: const Icon(Icons.update))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 15),
              Expanded(
                  child: TextField(
                controller: _description,
                maxLines: 50,
                decoration: InputDecoration(
                    hintText: 'Start typing here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ))
            ],
          ),
        ));
  }

  _insertEntry() async {
    final entry = MyEntry(
        usermail: widget.cred?.user.email ?? '',
        date: DateTime.now(),
        title: _title.text,
        feeling: "TODO",
        content: _description.text);
    await EntriesRepository.insert(entry: entry);
  }

  _updateEntry() async {
    final entry = MyEntry(
        id: widget.entry!.id!,
        usermail: widget.entry!.usermail,
        date: widget.entry!.date,
        title: _title.text,
        feeling: "TODO",
        content: _description.text);
    await EntriesRepository.update(entry: entry);
  }
}
