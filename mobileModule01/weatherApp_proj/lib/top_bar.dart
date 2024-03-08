import 'package:flutter/material.dart';

class MyTopBar extends StatelessWidget implements PreferredSizeWidget {

  const MyTopBar({
    super.key,
    required this.changeText,
    required this.backgroundColor,
  });

  final Function(String newText)  changeText;
  final Color                     backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () {
            debugPrint("button pressed");
          },
          icon: const Icon(Icons.search),
          color: Colors.white,
        ),
        toolbarHeight: 80.2,
        backgroundColor: backgroundColor,
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
      );}

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}