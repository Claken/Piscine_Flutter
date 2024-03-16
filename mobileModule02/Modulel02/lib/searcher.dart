import 'package:flutter/material.dart';

class CityInfoPage extends StatelessWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
  });

  final dynamic listOfCities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: listOfCities?.length ?? 10,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
              height: 20,
              child: Container(
                child: listOfCities != null
                    ? Text(
                        '${listOfCities?[index]['name']}, ${listOfCities?[index]['admin1']}, ${listOfCities?[index]['country']} '
                        
                        )
                    : const Text('wait for list'),
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
  }
}
