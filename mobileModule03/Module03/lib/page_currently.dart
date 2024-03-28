import 'package:ex00/error_message.dart';
import 'package:ex00/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentlyPage extends StatelessWidget {
  CurrentlyPage({
    super.key,
    required this.coord,
    required this.current,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, String> current;
  final String errorText;

  final Map<String, IconData> wIcons = weatherIcons;
  final double heightInt = 50.0;

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: coord['cityName'] != null && coord['cityName']!.isNotEmpty ? <Widget>[
                Text(
                  "${coord['cityName']}", style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "${coord['region']}, ${coord['country']}", style: const TextStyle(color: Colors.white)
                ),
                 SizedBox(height: heightInt),
                Text(
                  "${current['temp']}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 30.00,
                  ),
                ),
                const SizedBox(height: 30.0),
                Icon(wIcons[current['weather']], color: Colors.blue), 
                Text(
                  "${current['weather']}", style: const TextStyle(color: Colors.blue)
                ),
                SizedBox(height: heightInt),
                const Icon(CupertinoIcons.wind, color: Colors.grey), 
                Text(
                  "${current['wind']}", style: const TextStyle(color: Colors.grey)
                ),
              ] : <Widget>[const Text('Please make a search of use the geolocation button')])
        : ErrorMessage(
            errorMessage: errorText,
          );
  }
}
