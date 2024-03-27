import 'dart:convert';
import 'package:ex00/app_body.dart';
import 'package:ex00/app_bottom_bar.dart';
import 'package:ex00/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({
    super.key,
  });

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> with TickerProviderStateMixin {
  final Color _iconColor = Colors.white.withOpacity(0.7);
  final Color _backgroundColor = const Color.fromARGB(255, 78, 68, 107);
  late TabController _tabController;
  dynamic _listOfCities;
  final Map<String, String> _location = location;
  final Map<String, String> _weatherMap = weatherMap;

  final _current = {'temp': '', 'weather': '', 'wind': ''};
  final Map<String, Map<String, String>> _today = {};
  final Map<String, Map<String, String>> _week = {};

  String _text = "";
  String _errorText = "";
  final String errorAPI = "No Connexion\nPlease check your Internet connexion";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeErrorText(String error) {
    setState(() {
      _errorText = error;
    });
  }

  void changeText(String newText) {
    setState(() {
      _text = newText;
    });
  }

  void changeLatAndLong(double lat, double long) async {
    String lati = lat.toString();
    String longi = long.toString();
    setState(() {
      _location['lat'] = lati;
      _location['long'] = longi;
    });
    if (lati != '' && longi != '') {
      await getCurrentInfo(lati, longi);
      await getTodayInfo(lati, longi);
      await getWeeklyInfo(lati, longi);
    }
  }

  void changeLocation(String name, String region, String country) {
    setState(() {
      _location['cityName'] = name;
      _location['region'] = region;
      _location['country'] = country;
    });
  }

  Future<void> getCityInfo(String cityName) async {
    cityName = _text;
    final url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=5&language=en&format=json';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      setState(() {
        _listOfCities = responseData["results"];
      });
      changeErrorText('');
    } catch (e) {
      changeErrorText(errorAPI);
      throw Exception("$e");
    }
  }

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
          String code = responseData['current_weather']['weathercode'].toString();
          _current['weather'] = _weatherMap[code]!;
          _current['wind'] =
              "${responseData['current_weather']['windspeed']} km/h";
        });
        changeErrorText('');
      }
    } catch (e) {
      changeErrorText(errorAPI);

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
        changeErrorText('');
      }
    } catch (e) {
      changeErrorText(errorAPI);

      throw Exception("$e");
    }
  }

  Future<void> getWeeklyInfo(String lat, String long) async {
    var dateTime = getFirstDayOfTheWeekInString();
    var url =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT&past_days=8&forecast_days=14";

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (responseData != null) {
        int i = 0;
        while (responseData['daily']['time'][i].toString() != dateTime) {
          i++;
          if (i > responseData['daily']['time'].length) {
            debugPrint("error");
            return;
          }
        }
        setState(() {
          int j = i + 7;
          while (i < j) {
            String date = responseData['daily']['time'][i].toString();
            String max =
                responseData['daily']['temperature_2m_max'][i].toString();
            String min =
                responseData['daily']['temperature_2m_min'][i].toString();
            String wcode = responseData['daily']['weather_code'][i].toString();
            String weather = _weatherMap[wcode] ?? '';
            _week[i.toString()] = {
              'date': date.replaceAll("-", "/"),
              'min': "$min°C",
              'max': "$max°C",
              'weather': weather,
            };
            i++;
          }
        });
        changeErrorText('');
      }
    } catch (e) {
      changeErrorText(errorAPI);

      throw Exception("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        changeText: changeText,
        changeErrorText: changeErrorText,
        text: _text,
        backgroundColor: _backgroundColor,
        getCityInfo: getCityInfo,
        changeLatAndLong: changeLatAndLong,
        changeLocation: changeLocation,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BodyOfApp(
            text: _text,
            errorText: _errorText,
            controller: _tabController,
            location: _location,
            current: _current,
            today: _today,
            week: _week,
            listOfCities: _listOfCities,
            changeText: changeText,
            changeLatAndLong: changeLatAndLong,
            changeLocation: changeLocation),
      ),
      bottomNavigationBar: BottomBar(
          backgroundColor: _backgroundColor,
          iconColor: _iconColor,
          tabController: _tabController),
    );
  }
}
