import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
    required this.changeText,
    required this.changeLatAndLong,
    required this.changeLocation,
  });

  final dynamic listOfCities;
  final Function(String newText) changeText;
  final Function(double lat, double long) changeLatAndLong;
  final Function(String name, String region, String country) changeLocation;

  @override
  Widget build(BuildContext context) {
    return listOfCities != null
        ? ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: listOfCities?.length ?? 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  onTap: () {
                    changeLatAndLong(listOfCities[index]["latitude"],
                        listOfCities[index]["longitude"]);
                    changeLocation(
                        listOfCities[index]['name'],
                        listOfCities[index]['admin1'] ?? listOfCities[index]['country'],
                        listOfCities[index]['country']);
                    changeText("");
                  },
                  title: Row(children: [
                    Text('${listOfCities?[index]['name']} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                    Expanded(
                        child: Text(
                      '${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']}',
                      style: const TextStyle(fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ))
                  ]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Center(child: Text('NO CITY FOUND', style: TextStyle(color: Colors.white)))]);
  }
}
