import 'package:ex00/chart_for_today.dart';
import 'package:ex00/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TodayPage extends StatelessWidget {
  TodayPage({
    super.key,
    required this.coord,
    required this.today,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> todayList() {
    List<Widget> list = [];

    list.addAll(today.entries.map((entry) => Container(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${entry.value['hour']}"),
              const SizedBox(height: 15.0),
              Icon(weatherIcons[entry.value['weather']], color: Colors.blue),
              const SizedBox(height: 15.0),
              Text(
                "${entry.value['temp']}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 15.00,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.wind, color: Colors.grey,),
                    Text(" ${entry.value['wind']}",
                        style: const TextStyle(color: Colors.grey)),
                  ]),
            ]))));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Text("${coord['cityName']}",
              style: const TextStyle(color: Colors.white)),
          Text("${coord['region']}, ${coord['country']}",
              style: const TextStyle(color: Colors.white)),
          Container(
              height: 20.0,
              margin: EdgeInsets.all(20),
              child: Center(child: Text("Today temperatures"))),
          ChartToday(map: today),
          Expanded(
              child: ListView(
                  scrollDirection: Axis.horizontal, children: todayList()))
        ]);
  }
}
