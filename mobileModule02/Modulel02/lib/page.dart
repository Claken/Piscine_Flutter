import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class APage extends StatefulWidget {
  const APage({
    super.key,
    required this.textOne,
    required this.coord,
    required this.currentTab,
  });

  final String textOne;
  final Map<String, String> coord;
  final int currentTab;

  @override
  State<APage> createState() => _APageState();
}

class _APageState extends State<APage> {
  final Map<String, String> _weatherMap = {
    '0': 'Clear sky',
    '1': 'Mainly clear',
    '2': 'Partly cloudy',
    '3': 'Overcast',
    '45': 'Fog and depositing rime fog',
    '48': 'Fog and depositing rime fog',
    '51': 'Drizzle: Light intensity',
    '53': 'Drizzle: Moderate intensity',
    '55': 'Drizzle: Dense intensity',
    '56': 'Freezing Drizzle: Light intensity',
    '57': 'Freezing Drizzle: Dense intensity',
    '61': 'Rain: Slight intensity',
    '63': 'Rain: Moderate intensity',
    '65': 'Rain: Heavy intensity',
    '66': 'Freezing Rain: Light intensity',
    '67': 'Freezing Rain: Heavy intensity',
    '71': 'Snow fall: Slight intensity',
    '73': 'Snow fall: Moderate intensity',
    '75': 'Snow fall: Heavy intensity',
    '77': 'Snow grains',
    '80': 'Rain showers: Slight intensity',
    '81': 'Rain showers: Moderate intensity',
    '82': 'Rain showers: Violent intensity',
    '85': 'Snow showers: Slight intensity',
    '86': 'Snow showers: Heavy intensity',
    '95': 'Thunderstorm: Slight or moderate',
    '96': 'Thunderstorm with slight hail',
    '99': 'Thunderstorm with heavy hail',
  };

  final _current = {'temp': '', 'weather': '', 'wind': ''};
  final Map<String, Map<String, String>> _today = {};
  final Map<String, Map<String, String>> _week = {};

  Future<void> getCurrentInfo(String lat, String long) async {
    var url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current_weather=true&weather_code';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData != null) {
        setState(() {
          _current['temp'] =
              "${responseData['current_weather']['temperature']}°C";
          var code = responseData['current_weather']['weathercode'];
          _current['weather'] = _weatherMap[code.toString()]!;
          _current['wind'] =
              "${responseData['current_weather']['windspeed']} km/h";
        });
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> getTodayInfo(String lat, String long) async {
    var url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&hourly=temperature_2m,weather_code,wind_speed_10m';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData != null) {
        setState(() {
          int i = 0;
          while (i < 24) {
            String hourAndDay = responseData["hourly"]['time'][i].toString();
            String hour = hourAndDay.substring(11);
            String temp =
                responseData["hourly"]['temperature_2m'][i].toString();
            String wcode = responseData["hourly"]['weather_code'][i].toString();
            String weather = _weatherMap[wcode] ?? '';
            String wind =
                responseData["hourly"]['wind_speed_10m'][i].toString();
            String index = i.toString();
            _today[index] = {
              'hour': hour,
              'temp': "$temp°C",
              'weather': weather,
              'wind': "$wind km/h"
            };
            i++;
          }
        });
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> getWeeklyInfo(String lat, String long) async {
    var url =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT&start_date=2024-03-18&end_date=2024-03-24";

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData != null) {
        setState(() {
          int i = -1;
          while (++i < 7) {
            String date = responseData['daily']['time'][i].toString();
            String max =
                responseData['daily']['temperature_2m_max'][i].toString();
            String min =
                responseData['daily']['temperature_2m_min'][i].toString();
            String wcode = responseData['daily']['weather_code'][i].toString();
            String weather = _weatherMap[wcode] ?? '';
            _week[i.toString()] = {
              'date': date,
              'min': "$min°C",
              'max': "$max°C",
              'weather': weather,
            };
          }
        });
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  whatToReturn() {
    if (widget.currentTab == 0) {
      if (widget.coord['lat'] != '' && widget.coord['long'] != '') {
        getCurrentInfo(widget.coord['lat'] ?? '', widget.coord['long'] ?? '');
      }
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${_current['temp']}",
            ),
            Text(
              "${_current['weather']}",
            ),
            Text(
              "${_current['wind']}",
            ),
          ]);
    }
    if (widget.currentTab == 1) {
      if (widget.coord['lat'] != '' && widget.coord['long'] != '') {
        getTodayInfo(widget.coord['lat'] ?? '', widget.coord['long'] ?? '');
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _today.entries
            .map(
              (entry) => Text(
                '${entry.value['hour']}   ${entry.value['temp']}    ${entry.value['wind']}    ${entry.value['weather']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
            .toList(),
      );
    }if (widget.currentTab == 2) {
      if (widget.coord['lat'] != '' && widget.coord['long'] != '') {
        getWeeklyInfo(widget.coord['lat'] ?? '', widget.coord['long'] ?? '');
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _week.entries
            .map(
              (entry) => Text(
                '${entry.value['date']}   ${entry.value['min']}    ${entry.value['max']}    ${entry.value['weather']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
            .toList(),
      );
    }
    return Text(
      "${widget.coord['lat']} ${widget.coord['long']}",
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.coord['cityName']}",
          ),
          Text(
            "${widget.coord['region']}",
          ),
          Text(
            "${widget.coord['country']}",
          ),
          whatToReturn(),
        ]);
  }
}
