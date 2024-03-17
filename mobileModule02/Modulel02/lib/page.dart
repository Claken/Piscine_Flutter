import 'package:flutter/material.dart';

class APage extends StatelessWidget {
  const APage({
    super.key,
    required this.textOne,
    required this.lat,
    required this.long,
  });

  final String  textOne;
  final double  lat;
  final double  long;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textOne,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            "$lat $long",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ]);
  }
}
