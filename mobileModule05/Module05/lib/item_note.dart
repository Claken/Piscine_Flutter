import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/models/feeling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNode extends StatelessWidget {
  const ItemNode({
    super.key,
    required this.entry,
  });

  final MyEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Column(children: [
              Text(DateFormat(DateFormat.ABBR_MONTH).format(entry.date),
                  style: const TextStyle(color: Colors.white70)),
              Text(DateFormat(DateFormat.DAY).format(entry.date),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text(entry.date.year.toString(),
                  style: const TextStyle(color: Colors.white70)),
            ])),
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              emojiMap[entry.feeling],
              size: 30,
              color: colorMap[entry.feeling],
            )),
        const SizedBox(width: 15),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium),
            Text(
              entry.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )),
      ],
    ));
  }
}
