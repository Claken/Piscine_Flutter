import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diaryapp/profile_page.dart';
import 'package:flutter/material.dart';

class Diary extends StatefulWidget {
   const Diary({
    super.key,
    required this.cred,
    required this.logout,
  });

  final Credentials? cred;
  final Future<void> Function() logout;
  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          ProfilePage(cred: widget.cred, logout: widget.logout),
          const Center(child: Text('caca'),),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.red,
        child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            onTap: (value) {
              _tabController.animateTo(value,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.bounceOut);
            },
            tabs: const [
              Tab(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  text: 'Profile'),
              Tab(
                  icon: Icon(Icons.calendar_month, color: Colors.white),
                  text: 'Agenda'),
            ],
    )));
  }
}