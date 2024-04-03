import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, String> weatherMap = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog and depositing rime fog',
  '48': 'Fog and depositing rime fog',
  '51': 'Drizzle: Light intensity',
  '53': 'Drizzle: Moderate intensity',
  '55': 'Drizzle: Dense intensity',
  '56': 'Freezing Drizzle: Light intensity',
  '57': 'Freezing Drizzle: Dense intensity',
  '61': 'Rain: Slight intensity',
  '63': 'Rain: Moderate intensity',
  '65': 'Rain: Heavy intensity',
  '66': 'Freezing Rain: Light intensity',
  '67': 'Freezing Rain: Heavy intensity',
  '71': 'Snow fall: Slight intensity',
  '73': 'Snow fall: Moderate intensity',
  '75': 'Snow fall: Heavy intensity',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight intensity',
  '81': 'Rain showers: Moderate intensity',
  '82': 'Rain showers: Violent intensity',
  '85': 'Snow showers: Slight intensity',
  '86': 'Snow showers: Heavy intensity',
  '95': 'Thunderstorm: Slight or moderate',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
};



void main() async {


  const String apiKey = '65f890b324662655210750wlrcc4094';
  const String lati = '48.9107872';
  const String longi = '2.3099892';
  const url ='https://geocode.maps.co/reverse?lat=$lati&lon=$longi&api_key=$apiKey';

  const String ll = '48.8534';
  const String ll2 = '2.3488';

  const currentUrl = 'https://api.open-meteo.com/v1/forecast?latitude=$ll&longitude=$ll2&current_weather=true&weather_code';

  const cityUrl = 'https://geocoding-api.open-meteo.com/v1/search?name=Rabat&count=5&language=en&format=json';
  
  
  

try {
  final response = await http.get(Uri.parse(url));
  final currentResponse = await http.get(Uri.parse(currentUrl));

  final responseData = json.decode(response.body);
  final currentResponseData = json.decode(currentResponse.body);

  final rdt = await http.get(Uri.parse(cityUrl));
  final dataGueule = json.decode(rdt.body);

  debugPrint(dataGueule["results"][0].toString());
  debugPrint("((pofkfkzeofkzepofkzpefkzpefokzepfokzpoefkzeofkzeofk))");

  // currently
  debugPrint("temperature ${currentResponseData['current_weather']['temperature']} °C");
  var code = currentResponseData['current_weather']['weathercode'].toString();
  debugPrint(weatherMap[code]);
  debugPrint("windspeed ${currentResponseData['current_weather']['windspeed']} km/h");

 
  debugPrint(responseData.toString());
  // debugPrint(responseData['address']['town']);
  // debugPrint(responseData['address']['state']);
  // debugPrint(responseData['address']['country']);

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