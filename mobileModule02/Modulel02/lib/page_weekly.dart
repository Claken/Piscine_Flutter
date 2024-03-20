import 'package:ex00/error_message.dart';
import 'package:flutter/material.dart';

class WeeklyPage extends StatelessWidget {
  const WeeklyPage({
    super.key,
    required this.coord,
    required this.weekly,
    required this.errorText,

  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> weekly;
  final String            errorText;


  List<Widget> weeklyList() {
    List<Widget> list = [];

    list.add(Center(child: Text("${coord['cityName']}")));
    list.add(Center(child: Text("${coord['region']}")));
    list.add(Center(child: Text("${coord['country']}")));
    list.addAll(weekly.entries.map(
      (entry) => Text(
        '${entry.value['date']}   ${entry.value['min']}    ${entry.value['max']}    ${entry.value['weather']}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty ? ListView(
        children: weeklyList() 
        )
        : ErrorMessage(errorMessage: errorText,)
        ;
  }
}
