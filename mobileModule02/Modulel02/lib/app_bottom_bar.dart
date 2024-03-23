import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.backgroundColor,
    required this.currentTab,
    required this.changeTab,
    required this.iconColor,
    required this.tabController,
  });

  final Color backgroundColor;
  final Color iconColor;
  final Function(int tab) changeTab;
  final int currentTab;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: currentTab,
      onTap: (value) {
          changeTab(value);
          tabController.animateTo(value,
              duration: const Duration(milliseconds: 1),
              curve: Curves.bounceOut);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: iconColor), label: 'Currently'),
        BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined, color: iconColor), label: 'Today'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: iconColor),
            label: 'Weekly')
      ],
    );
  }
}
