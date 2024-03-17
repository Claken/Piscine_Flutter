import 'dart:convert';

import 'package:ex00/bottom_bar.dart';
import 'package:ex00/page.dart';
import 'package:ex00/searcher.dart';
import 'package:ex00/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final Color _iconColor = Colors.white.withOpacity(0.7);
  final Color _backgroundColor = const Color.fromARGB(255, 78, 68, 107);
  final       _pageViewController = PageController();
  dynamic     _listOfCities;
  double?     _cityLatitude;
  double?     _cityLongitude;
  dynamic     _cityWeather;

  int _currentTab = 0;
  String _text = "";

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  void changeText(String newText) {
    setState(() {
      _text = newText;
    });
  }

  void changeLatAndLong(double lat, double long) {
    setState(() {
      _cityLatitude = lat;
      _cityLongitude = long;
    });

  }

  Future<void> getCityInfo(String cityName) async {
    cityName = _text;
    final url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=10&language=en&format=json';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      setState(() {
        _listOfCities = responseData["results"];
      });
    } catch (e) {
      throw Exception("$e");
    }
  }

  // Future<void> getWeather(double lat, double long) {
  //   final url = 
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        changeText: changeText,
        text: _text,
        backgroundColor: _backgroundColor,
        getCityInfo: getCityInfo,
        changeLatAndLong: changeLatAndLong,
      ),
      body: _text.isEmpty
          ? PageView(
              controller: _pageViewController,
              onPageChanged: (value) {
                changeTab(value);
              },
              children: [
                  APage(textOne: "Currently", lat: _cityLatitude ?? 0.0, long: _cityLongitude ??  0.0),
                  APage(textOne: "Today", lat: _cityLatitude ?? 0.0, long: _cityLongitude ?? 0.0),
                  APage(textOne: "Weekly", lat: _cityLatitude ?? 0.0, long: _cityLongitude ?? 0.0),
                ])
          : CityInfoPage(
              listOfCities: _listOfCities,
              changeText: changeText,
              changeLatAndLong: changeLatAndLong),
      bottomNavigationBar: BottomBar(
          backgroundColor: _backgroundColor,
          currentTab: _currentTab,
          changeTab: changeTab,
          iconColor: _iconColor,
          pageViewController: _pageViewController),
    );
  }
}
