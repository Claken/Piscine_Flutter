import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
  });

  final dynamic listOfCities;

  @override
  Widget build(BuildContext context) {
    return listOfCities != null
        ? ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: listOfCities?.length ?? 10,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                  height: 20,
                  child: Text(
                      '${listOfCities?[index]['name']}, ${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']} '));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        : const Center(child: Text('no city found'));
  }
}
