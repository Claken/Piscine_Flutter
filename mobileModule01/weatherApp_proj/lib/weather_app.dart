import 'package:ex00/bottom_bar.dart';
import 'package:ex00/page.dart';
import 'package:ex00/top_bar.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final Color _iconColor = Colors.white.withOpacity(0.7);
  final Color _backgroundColor = const Color.fromARGB(255, 78, 68, 107);
  final _pageViewController = PageController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        changeText: changeText,
        backgroundColor: _backgroundColor,
      ),
      body: PageView(
          controller: _pageViewController,
          onPageChanged: (value) => changeTab(value),
          children: [
            APage(textOne: "Currently", textTwo: _text),
            APage(textOne: "Today", textTwo: _text),
            APage(textOne: "Weekly", textTwo: _text),
          ]),
      bottomNavigationBar: BottomBar(
          backgroundColor: _backgroundColor,
          currentTab: _currentTab,
          changeTab: changeTab,
          iconColor: _iconColor,
          pageViewController: _pageViewController),
    );
  }
}
