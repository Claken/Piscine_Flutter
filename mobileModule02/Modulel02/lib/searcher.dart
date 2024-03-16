import 'package:flutter/material.dart';

class CityInfoPage extends StatefulWidget {
  const CityInfoPage({
    super.key,
    required this.listOfCities,
  });

  final dynamic listOfCities;

  @override
  State<CityInfoPage> createState() => _CityInfoPageState();
}

class _CityInfoPageState extends State<CityInfoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.listOfCities == null ? widget.listOfCities?.length : 10,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20,
            child: Center(
                child: widget.listOfCities == null
                ? Text(
                    '${widget.listOfCities?[index]['name']}, ${widget.listOfCities?[index]['admin1']}, ${widget.listOfCities?[index]['country']} ')
                : const Text('wait for list'),
          ));
        });
  }
}
