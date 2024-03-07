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
          child: Text('Hello World!'),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 78, 68, 107),
          child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.rocket),),
                    Tab(icon: Icon(Icons.rocket),),
                    Tab(icon: Icon(Icons.rocket),)
                  ]
                ),
              ),
                body: TabBarView(children: [
                  Container(color: Colors.white, child: const Icon(Icons.rocket)),
                  Container(color: Colors.white, child: const Icon(Icons.rocket)),
                  Container(color: Colors.white, child: const Icon(Icons.rocket)),
                ],) 
              )
              ),
        ),
      ),
    );
  }
}
