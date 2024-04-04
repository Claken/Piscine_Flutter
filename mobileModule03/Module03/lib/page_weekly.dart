import 'package:ex00/chart_for_weekly.dart';
import 'package:ex00/utils.dart';
import 'package:flutter/material.dart';

class WeeklyPage extends StatelessWidget {
  WeeklyPage({
    super.key,
    required this.coord,
    required this.weekly,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> weekly;
  final yourScrollController = ScrollController();

  final Map<String, IconData> wIcons = weatherIcons;

  List<Widget> weeklyList() {
    List<Widget> list = [];

    list.addAll(weekly.entries.map((entry) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${entry.value['date']}"),
              const SizedBox(height: 20.0),
              Icon(weatherIcons[entry.value['weather']], color: Colors.blue),
              const SizedBox(height: 10.0),
              Text(
                "${entry.value['max']}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 15.00,
                ),
              ),
              Text(
                "${entry.value['min']}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 204, 255),
                  fontSize: 15.00,
                ),
              ),
            ]))));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
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
              margin: const EdgeInsets.all(20),
              child: const Center(child: Text("Weekly temperatures", style: TextStyle(color: Colors.white)))),
            
          ChartWeek(map: weekly),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                ),
                Icon(Icons.show_chart, color: Colors.blue),
                Text('min temperature', style: TextStyle(color: Colors.white)),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.show_chart, color: Colors.orange),
                Text('max temperature', style: TextStyle(color: Colors.white)),
              ]),
          SizedBox(
              height: 170,
              child: RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: Colors.lightBlueAccent,
                  radius: const Radius.circular(20),
                  thickness: 5,
                  controller: yourScrollController,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      controller: yourScrollController,
                      children: weeklyList())))
        ]));
  }
}
