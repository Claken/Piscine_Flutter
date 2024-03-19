import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
    required this.coord,
    required this.today,
  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;

  List<Text> todayList() {

    List<Text> list = [];

    list.add(Text("${coord['cityName']}"));
    list.add(Text("${coord['region']}"));
    list.add(Text("${coord['country']}"));
    list.addAll(today.entries
            .map(
              (entry) => Text(
                '${entry.value['hour']}   ${entry.value['temp']}    ${entry.value['wind']}    ${entry.value['weather']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: todayList());
}}