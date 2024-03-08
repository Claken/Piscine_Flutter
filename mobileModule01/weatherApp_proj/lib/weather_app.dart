import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  
  final List<String> _tabsText = ['Currently', 'Today', 'Weekly'];
  int _currentTab = 0;

  void changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            debugPrint("button pressed");
          },
          icon: const Icon(Icons.search),
          color: Colors.white,
        ),
        toolbarHeight: 80.2,
        backgroundColor: const Color.fromARGB(255, 78, 68, 107),
        title: Text(
          'Search location...',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.1)),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const VerticalDivider(color: Colors.white),
              IconButton(
                onPressed: () {
                  debugPrint("button pressed");
                },
                icon: const Icon(
                  Icons.location_on,
                ),
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Text(
          _tabsText[_currentTab],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 78, 68, 107),
        onTap: (value) => changeTab(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: 'Currently'),
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Weekly')
        ],
      ),
    );
  }
}
