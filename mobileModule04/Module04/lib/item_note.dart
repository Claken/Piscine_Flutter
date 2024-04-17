import 'package:flutter/material.dart';

class ItemNode extends StatelessWidget {
  const ItemNode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
            child: Column(children: [
          Text('DEC'),
          Text('02'),
          Text('2023'),
        ])),
        Expanded(
            child: Column(
          children: [
            Text('This is the title'),
            Text('Here is the description of this note'),
          ],
        ))
      ],
    ));
  }
}
