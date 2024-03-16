import 'package:flutter/material.dart';
import 'geolocation.dart' as location;

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

  void clearText() {
    _controller.clear();
  }

  Widget textFieldOrNot() {
    if (_textFieldVisible == false) {
      return Text(
        'Search location...',
        style: TextStyle(
            fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.1)),
      );
    }
    return TextField(
      style: TextStyle(
          fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.5)),
      controller: _controller,
      onChanged: (value) {
        widget.changeText(value);
        },
      decoration: InputDecoration(
       hintText: 'Search location...',
        hintStyle: TextStyle(
            fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.5)),
      ),
    );
  }

  IconButton searchOrCross() {
    if (_textFieldVisible == false) {
      return IconButton(
        onPressed: () {
          clearText();
          _toggleTextFieldVisibility();
        },
        icon: const Icon(Icons.search),
        color: Colors.white,
      );
    }
    return IconButton(
      onPressed: () {
        _toggleTextFieldVisibility();
        widget.changeText("");
      },
      icon: const Icon(Icons.close),
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: searchOrCross(),
      toolbarHeight: 80.2,
      backgroundColor: widget.backgroundColor,
      title: textFieldOrNot(),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const VerticalDivider(color: Colors.white),
            IconButton(
              onPressed: () async {
                if (await location.LocationService().requestPermission()) {
                  final geolocation = await location.LocationService().getCurrentLocation();
                  final String lat = geolocation.latitude.toString();
                  final String long = geolocation.longitude.toString();
                  widget.changeText('$lat $long');
                }
                else {
                  widget.changeText('Geolocation is not available.\nPlease enable it.');
                }
              },
              icon: const Icon(
                Icons.location_on,
              ),
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
