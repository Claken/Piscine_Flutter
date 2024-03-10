import 'package:flutter/material.dart';

class MyTopBar extends StatefulWidget implements PreferredSizeWidget {
  const MyTopBar({
    super.key,
    required this.changeText,
    required this.backgroundColor,
  });

  final Function(String newText) changeText;
  final Color backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MyTopBar> createState() => _MyTopBarState();
}

class _MyTopBarState extends State<MyTopBar> {
  bool _textFieldVisible = false;
  final TextEditingController _controller = TextEditingController();

  void _toggleTextFieldVisibility() {
    setState(() {
      _textFieldVisible = !_textFieldVisible;
    });
  }

  Widget visibleOrNot() {
    if (_textFieldVisible == false) {
      return Text(
        'Search location...',
        style: TextStyle(
            fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.1)),
      );
    }
    return TextField(
      controller: _controller,
      onChanged: (value) => widget.changeText(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          _toggleTextFieldVisibility();
        },
        icon: const Icon(Icons.search),
        color: Colors.white,
      ),
      toolbarHeight: 80.2,
      backgroundColor: widget.backgroundColor,
      title: visibleOrNot(),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const VerticalDivider(color: Colors.white),
            IconButton(
              onPressed: () {
                widget.changeText("Paris");
              },
              icon: const Icon(
                Icons.location_on,
              ),
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
