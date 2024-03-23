import 'package:ex00/page_currently.dart';
import 'package:ex00/page_today.dart';
import 'package:ex00/page_weekly.dart';
import 'package:ex00/searcher.dart';
import 'package:flutter/material.dart';

class BodyOfApp extends StatelessWidget {
  const BodyOfApp({
    super.key,
    required this.text,
    required this.errorText,
    required this.controller,
    required this.location,
    required this.current,
    required this.today,
    required this.week,
    required this.listOfCities,
    required this.changeTab,
    required this.changeText,
    required this.changeLatAndLong,
    required this.changeLocation,
  });

  final String text;
  final String errorText;
  final TabController controller;
  final Map<String, String> location;
  final Map<String, String> current;
  final Map<String, Map<String, String>> today;
  final Map<String, Map<String, String>> week;
  final dynamic listOfCities;
  final Function(int newTab) changeTab;
  final Function(String newText) changeText;
  final Function(double lat, double long) changeLatAndLong;
  final Function(String name, String region, String country) changeLocation;

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return CityInfoPage(
          listOfCities: listOfCities,
          changeText: changeText,
          changeLatAndLong: changeLatAndLong,
          changeLocation: changeLocation,
          errorText: errorText);
    }
    return TabBarView(
        controller: controller,
        // onPageChanged: (value) {
        //   changeTab(value);
        // },
        children: [
          CurrentlyPage(
            coord: location,
            current: current,
            errorText: errorText,
          ),
          TodayPage(
            coord: location,
            today: today,
            errorText: errorText,
          ),
          WeeklyPage(
            coord: location,
            weekly: week,
            errorText: errorText,
          ),
        ]);
  }
}
