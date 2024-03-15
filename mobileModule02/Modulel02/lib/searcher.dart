import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityInfoPage extends StatefulWidget {

  const CityInfoPage({
    super.key,
    required this.searchText,
  });

  final String searchText;

  @override
  State<CityInfoPage> createState() => _CityInfoPageState();
}

class _CityInfoPageState extends State<CityInfoPage> {
  String    ityName = '';
  dynamic   responseData;


  Future<void> getCityInfo(String cityName) async {
    cityName = widget.searchText;
    final url = 'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=10&language=en&format=json';

    final response = await http.get(Uri.parse(url));

    setState(() {
    responseData = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var result in responseData) Text(result.toString())],
        ),
      ),
    );
  }
}
