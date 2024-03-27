import 'package:ex00/error_message.dart';
import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
    required this.changeText,
    required this.changeLatAndLong,
    required this.changeLocation,
    required this.errorText,
  });

  final dynamic listOfCities;
  final Function(String newText) changeText;
  final Function(double lat, double long) changeLatAndLong;
  final Function(String name, String region, String country) changeLocation;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return listOfCities != null
        ? ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: listOfCities?.length ?? 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  onTap: () {
                    if (listOfCities[index]["latitude"] != null &&
                        listOfCities[index]["longitude"] != null) {
                      changeLatAndLong(listOfCities[index]["latitude"],
                          listOfCities[index]["longitude"]);
                      changeText("");
                    }
                    if (listOfCities[index]['name'] != null &&
                        listOfCities[index]['admin1'] != null &&
                        listOfCities[index]['country'] != null) {
                      changeLocation(
                          listOfCities[index]['name'],
                          listOfCities[index]['admin1'],
                          listOfCities[index]['country']);
                    }
                  },
                  title: Row(children: [
                    Text('${listOfCities?[index]['name']} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Expanded(child: Text(
                        '${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']}',
                        style: const TextStyle(fontWeight: FontWeight.w300))
                  )])
                  
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        : errorText.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text('no city found'))])
            : ErrorMessage(errorMessage: errorText);
  }
}