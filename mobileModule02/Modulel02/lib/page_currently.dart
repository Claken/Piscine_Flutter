import 'package:flutter/material.dart';

class CurrentlyPage extends StatelessWidget {
  const CurrentlyPage({
    super.key,
    required this.coord,
    required this.current,
  });

  final Map<String, String> coord;
  final Map<String, String> current;

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
            "${current['temp']}",
          ),
          Text(
            "${current['weather']}",
          ),
          Text(
            "${current['wind']}",
          ),
        ]);
  }
}
