import 'package:ex00/top_bar.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final List<String> _tabsText = ['Currently', 'Today', 'Weekly'];
  final Color _iconColor = Colors.white.withOpacity(0.7);
  final Color _backgroundColor = const Color.fromARGB(255, 78, 68, 107);
  int _currentTab = 0;
  String _text = "fefef";

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
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text(
              _tabsText[_currentTab],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              _text,
            ),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _backgroundColor,
        currentIndex: _currentTab,
        onTap: (value) => changeTab(value),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: _iconColor),
              label: 'Currently'),
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined, color: _iconColor),
              label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined, color: _iconColor),
              label: 'Weekly')
        ],
      ),
    );
  }
}
