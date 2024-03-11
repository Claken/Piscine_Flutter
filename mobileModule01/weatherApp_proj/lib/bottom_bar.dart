import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.backgroundColor,
    required this.currentTab,
    required this.changeTab,
    required this.iconColor,
    required this.pageViewController,
  });

  final Color backgroundColor;
  final Color iconColor;
  final Function(int tab) changeTab;
  final int currentTab;
  final PageController pageViewController;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: widget.backgroundColor,
      currentIndex: widget.currentTab,
      onTap: (value) {
        widget.pageViewController.animateToPage(value,
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceOut);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: widget.iconColor),
            label: 'Currently'),
        BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined, color: widget.iconColor),
            label: 'Today'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: widget.iconColor),
            label: 'Weekly')
      ],
    );
  }
}
