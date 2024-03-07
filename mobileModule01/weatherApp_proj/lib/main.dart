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
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 78, 68, 107),
          height: 120,
          child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 78, 68, 107),
                bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.rocket, color: Colors.white), text: "Currently"),
                    Tab(icon: Icon(Icons.today_outlined, color: Colors.white), text: "Today"),
                    Tab(icon: Icon(Icons.calendar_month_outlined, color: Colors.white), text: "Weekly")
                  ]
                ),
              ),
                body: const TabBarView(children: [
                  Icon(Icons.rocket),
                  Icon(Icons.g_mobiledata_outlined),
                  Icon(Icons.rocket),
                ],) 
              )
              ),
        ),
      ),
    );
  }
}
