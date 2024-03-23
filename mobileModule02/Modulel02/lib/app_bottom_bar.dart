import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.tabController,
  });

  final Color backgroundColor;
  final Color iconColor;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: backgroundColor,
        child: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: iconColor,
            onTap: (value) {
              tabController.animateTo(value,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.bounceOut);
            },
            tabs: [
              Tab(
                  icon: Icon(Icons.settings, color: iconColor),
                  text: 'Currently'),
              Tab(
                  icon: Icon(Icons.today_outlined, color: iconColor),
                  text: 'Today'),
              Tab(
                  icon: Icon(Icons.calendar_month_outlined, color: iconColor),
                  text: 'Weekly'),
            ]));
  }
}
