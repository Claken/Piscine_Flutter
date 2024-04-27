import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/models/feeling.dart';
import 'package:diaryapp/repository/entries_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  String? _selectedValue;

  final List<String> items = [
    'Happy',
    'Satisfied',
    'Normal',
    'Sad',
    'Angry',
  ];

  @override
  void initState() {
    if (widget.entry != null) {
      _title.text = widget.entry!.title;
      _description.text = widget.entry!.content;
      if (widget.entry!.feeling != '') {
        _selectedValue = widget.entry!.feeling;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.entry == null ? 'Add note' : 'Update note'),
            actions: [
              widget.entry == null
                  ? IconButton(
                      onPressed: () async {
                        if (_title.text.isNotEmpty) {
                          await _insertEntry();
                          widget.reloadPage();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: const Icon(Icons.done))
                  : IconButton(
                      onPressed: () async {
                        if (_title.text.isNotEmpty) {
                          await _updateEntry();
                          widget.reloadPage();
                        }
                      },
                      icon: const Icon(Icons.update))
            ]),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _title,
                maxLength: 40,
                decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Title is required',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 255, 99, 88)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 15),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Feeling',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: _selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 200,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color.fromARGB(255, 158, 158, 158),
                          ),
                          color: Theme.of(context).canvasColor),
                      elevation: 0,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(10),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 110),
                    child: Icon(
                      emojiMap[_selectedValue ?? Icons.sentiment_neutral],
                      size: 50,
                      color: colorMap[_selectedValue],
                    )),
              ]),
              const SizedBox(height: 15),
              Expanded(
                  child: TextField(
                controller: _description,
                maxLength: 4000,
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
        feeling: _selectedValue ?? '',
        content: _description.text);
    await EntriesRepository.insert(entry: entry);
  }

  _updateEntry() async {
    final entry = MyEntry(
        id: widget.entry!.id!,
        usermail: widget.entry!.usermail,
        date: widget.entry!.date,
        title: _title.text,
        feeling: _selectedValue ?? '',
        content: _description.text);
    await EntriesRepository.update(entry: entry);
  }
}
