import 'package:flutter/material.dart';

class APage extends StatelessWidget {
  const APage({
    super.key,
    required this.textOne,
    required this.coord,
  });

  final String                textOne;
  final Map<String, String>   coord;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${coord['cityName']}",
          ),
          Text(
            "${coord['region']}",
          ),
          Text(
            "${coord['country']}",
          ),
          Text(
            "${coord['lat']} ${coord['long']}",
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
