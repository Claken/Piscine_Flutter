import 'package:ex00/chart_for_weekly.dart';
import 'package:ex00/error_message.dart';
import 'package:ex00/utils.dart';
import 'package:flutter/material.dart';

class WeeklyPage extends StatelessWidget {
  WeeklyPage({
    super.key,
    required this.coord,
    required this.weekly,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> weekly;
  final String errorText;

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> weeklyList() {
    List<Widget> list = [];

    list.addAll(weekly.entries.map((entry) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${entry.value['date']}"),
              const SizedBox(height: 20.0),
              Icon(weatherIcons[entry.value['weather']], color: Colors.blue),
              const SizedBox(height: 20.0),
              Text(
                "${entry.value['min']}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 204, 255),
                  fontSize: 20.00,
                ),
              ),
              Text(
                "${entry.value['max']}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20.00,
                ),
              ),
            ]))));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                const SizedBox(height: 50.0),
                Text("${coord['cityName']}",
                    style: const TextStyle(color: Colors.white)),
                Text("${coord['region']}, ${coord['country']}",
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20.0),
                ChartWeek(map: weekly),
                Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: weeklyList()))
              ])
        : ErrorMessage(
            errorMessage: errorText,
          );
  }
}
