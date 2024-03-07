import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: const Center(
          child: Text('A TEXT BITCH'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 78, 68, 107),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.rocket), label: 'Currently'),
            BottomNavigationBarItem(
                icon: Icon(Icons.today_outlined), label: 'Today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Weekly')
          ],
        ),
      ),
    );
  }
}
