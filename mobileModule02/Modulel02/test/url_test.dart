import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  // const url = 'https://geocoding-api.open-meteo.com/v1/search?name=Berli&count=10&language=en&format=json';

  const url2 = 'https://api.open-meteo.com/v1/forecast?latitude=48.8534&longitude=2.3488&hourly=temperature_2m';

try {
  // final response = await http.get(Uri.parse(url));
  final response2 = await http.get(Uri.parse(url2));

  // final responseData = json.decode(response.body);
  final responseData2 = json.decode(response2.body);

  // int len = responseData["results"].length;

  debugPrint(responseData2.toString());

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