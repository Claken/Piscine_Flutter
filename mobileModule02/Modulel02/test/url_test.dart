import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  // const url = 'https://geocoding-api.open-meteo.com/v1/search?name=Berli&count=10&language=en&format=json';

  const currentUrl = 'https://api.open-meteo.com/v1/forecast?latitude=48.8534&longitude=2.3488&current_weather=true';
  
  
  

try {
  // final response = await http.get(Uri.parse(url));
  final currentResponse = await http.get(Uri.parse(currentUrl));

  // final responseData = json.decode(response.body);
  final currentResponseData = json.decode(currentResponse.body);

  // int len = responseData["results"].length;

  debugPrint("windspeed ${currentResponseData['current_weather']['windspeed']} km/h");
  debugPrint("temperature ${currentResponseData['current_weather']['temperature']} °C");
  debugPrint(currentResponseData.toString());

  // debugPrint(len.toString());

//   int i = 0;
//   for (var data in responseData['results']) {
//     debugPrint(data['name']);
//     debugPrint(data['admin1']);
//     debugPrint(data['country']);
//     debugPrint(" --------------- $i");

//     debugPrint(data.toString());

//     i++;
//   }
}
catch (e) {
  debugPrint(e.toString());
    throw Exception();
}
  
}