import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
    required this.changeText,
    required this.changeLatAndLong,
  });

  final dynamic listOfCities;
  final Function(String newText) changeText;
  final Function(double lat, double long) changeLatAndLong;

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
                        listOfCities?[index]["longitude"] != null) {
                      changeLatAndLong(listOfCities[index]["latitude"],
                          listOfCities[index]["longitude"]);
                        debugPrint(
                        "${listOfCities?[index]["latitude"]}, ${listOfCities?[index]["longitude"]} ");
                        changeText("");
                    }
                  },
                  title: Text(
                      '${listOfCities?[index]['name']}, ${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']} '));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        : const Center(child: Text('no city found'));
  }
}
