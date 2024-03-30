import 'package:ex00/chart.dart';
import 'package:ex00/error_message.dart';
import 'package:ex00/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TodayPage extends StatelessWidget {
  TodayPage({
    super.key,
    required this.coord,
    required this.today,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;
  final String errorText;

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> todayList() {
    List<Widget> list = [];

    list.addAll(today.entries.map((entry) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${entry.value['hour']}"),
              Text(
                "${entry.value['temp']}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20.00,
                ),
              ),
              const SizedBox(height: 20.0),
              Icon(weatherIcons[entry.value['weather']], color: Colors.blue),
              const SizedBox(height: 20.0),
              const Icon(CupertinoIcons.wind, color: Colors.grey),
              Text("${entry.value['wind']}",
                  style: const TextStyle(color: Colors.grey)),
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
                // ChartYeah(mapType: 'today', map: today),
                Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: todayList()))
              ])
        : ErrorMessage(
            errorMessage: errorText,
          );
  }
}
