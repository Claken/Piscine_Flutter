import 'package:ex00/error_message.dart';
import 'package:flutter/material.dart';

class CurrentlyPage extends StatelessWidget {
  const CurrentlyPage({
    super.key,
    required this.coord,
    required this.current,
    required this.errorText,
  });

  final Map<String, String> coord;
  final Map<String, String> current;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return errorText.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                   style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 30.00,
                    ),
                ),
                Text(
                  "${current['weather']}",
                ),
                Text(
                  "${current['wind']}",
                ),
              ])
        : ErrorMessage(
            errorMessage: errorText,
          );
  }
}
