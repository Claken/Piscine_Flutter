import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  const url = 'https://geocoding-api.open-meteo.com/v1/search?name=Berli&count=10&language=en&format=json';

try {
  final response = await http.get(Uri.parse(url));

  final responseData = json.decode(response.body);

  int i = 0;
  for (var data in responseData['results']) {
    debugPrint(data['name']);
    debugPrint(data['admin1']);
    debugPrint(data['country']);

    debugPrint(" --------------- $i");
    i++;
  }
}
catch (e) {
  debugPrint(e.toString());
    throw Exception("$e");
}
  
}