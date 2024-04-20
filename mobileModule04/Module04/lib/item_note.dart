import 'package:diaryapp/models/entry.dart';
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
            child: Column(children: [
          Text(
            DateFormat(DateFormat.ABBR_MONTH).format(entry.date)
          ),
          Text(
            DateFormat(DateFormat.DAY).format(entry.date)
          ),
          Text(
            entry.date.year.toString()
          ),
        ])),
        Expanded(
            child: Column(
          children: [
            Text(
              entry.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              entry.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )),
      Text(
        DateFormat(DateFormat.HOUR_MINUTE).format(entry.date),
        style: Theme.of(context).textTheme.bodySmall
      )
      ],
    ));
  }
}
