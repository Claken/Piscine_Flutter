import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    required this.cred,
  });

  final Credentials? cred;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add note'), actions: [
          IconButton(
              onPressed: () {
                _insertEntry();
              },
              icon: const Icon(Icons.done))
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
}
