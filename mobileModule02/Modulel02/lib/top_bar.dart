import 'dart:convert';

import 'package:flutter/material.dart';
import 'geolocation.dart' as location;
import 'package:http/http.dart' as http;

class MyTopBar extends StatefulWidget implements PreferredSizeWidget {
  const MyTopBar({
    super.key,
    required this.changeText,
    required this.changeErrorText,
    required this.text,
    required this.backgroundColor,
    required this.getCityInfo,
    required this.changeLatAndLong,
    required this.changeLocation,
  });

  final Function(String newText) changeText;
  final Function(String error) changeErrorText;
  final Color backgroundColor;
  final String text;
  final Function(String cityName) getCityInfo;
  final Function(double lat, double long) changeLatAndLong;
  final Function(String name, String region, String country) changeLocation;

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
        widget.getCityInfo(widget.text);
      },
      decoration: InputDecoration(
        hintText: 'Search location...',
        hintStyle: TextStyle(
            fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.5)),
      ),
    );
  }

  Future<void> reverseGeocoding(double lat, double long) async {
    // const String apiKey = '65f890b324662655210750wlrcc4094';
    final String lati = lat.toString();
    final String longi = long.toString();
    final url =
        'https://geocode.maps.co/reverse?lat=$lati&lon=$longi&api_key=65f890b324662655210750wlrcc4094';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      final String cityName = responseData['address']['town'];
      final String cityRegion = responseData['address']['state'];
      final String cityCountry = responseData['address']['country'];
      widget.changeLocation(cityName, cityRegion, cityCountry);
    } catch (e) {
      throw Exception("$e");
    }
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
                  final geolocation =
                      await location.LocationService().getCurrentLocation();
                  final double? lat = geolocation.latitude;
                  final double? long = geolocation.longitude;
                  if (lat != null && long != null) {
                    widget.changeLatAndLong(lat, long);
                    reverseGeocoding(lat, long);
                    widget.changeErrorText("");
                  }
                } else {
                  widget.changeErrorText("Geolocation is not available\nPlease enable it");
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
