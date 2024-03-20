import 'package:ex00/error_message.dart';
import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
    required this.coord,
    required this.today,
    required this.errorText,

  });

  final Map<String, String> coord;
  final Map<String, Map<String, String>> today;
  final String            errorText;


  List<Widget> todayList() {
    List<Widget> list = [];

    list.add(Center(child: Text("${coord['cityName']}")));
    list.add(Center(child: Text("${coord['region']}")));
    list.add(Center(child: Text("${coord['country']}")));
    list.addAll(today.entries.map(
      (entry) => Text(
        '${entry.value['hour']}   ${entry.value['temp']}    ${entry.value['wind']}    ${entry.value['weather']}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty ? ListView(
        children: todayList()
        ) : ErrorMessage(errorMessage: errorText,)
        
        ;
  }
}
