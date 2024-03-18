import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {


  const String apiKey = '65f890b324662655210750wlrcc4094';
  const String lati = '48.9107872';
  const String longi = '2.3099892';
  final url ='https://geocode.maps.co/reverse?lat=$lati&lon=$longi&api_key=$apiKey';

  const currentUrl = 'https://api.open-meteo.com/v1/forecast?latitude=48.8534&longitude=2.3488&current_weather=true';
  
  
  

try {
  final response = await http.get(Uri.parse(url));
  final currentResponse = await http.get(Uri.parse(currentUrl));

  final responseData = json.decode(response.body);
  final currentResponseData = json.decode(currentResponse.body);


  debugPrint("windspeed ${currentResponseData['current_weather']['windspeed']} km/h");
  debugPrint("temperature ${currentResponseData['current_weather']['temperature']} °C");
  debugPrint(currentResponseData.toString());
  debugPrint(responseData.toString());
  debugPrint(responseData['address']['town']);
  debugPrint(responseData['address']['state']);
  debugPrint(responseData['address']['country']);

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