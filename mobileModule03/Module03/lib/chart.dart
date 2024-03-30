import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final String y;
}

class ChartYeah extends StatelessWidget {
  const ChartYeah({
    super.key,
    required this.mapType,
    required this.map,
  });

  final String mapType;
  final Map<String, Map<String, String>> map;

  List<FlSpot> chartList() {
    List<FlSpot> list = [];

    list.addAll(map.entries.map((entry) {
      String? temp = entry.value['temp'];
      String? hour = entry.value['hour'];

      if (temp != null && hour != null) {
        temp = temp.replaceAll('°C', '');
        double tempe = double.parse(temp);
        hour = hour.replaceAll(':', '.');
        double dhour = double.parse(hour);

        return FlSpot(tempe, dhour);
      }
      return const FlSpot(0.0, 0.0);
    }));
    return list;
  }

  double highestTemp() {
    Map<String, String>? caca = map['temp'];
    if (caca != null) {
      String temp = caca.values.reduce((value, element) => value.length > element.length ? value : element);
      temp = temp.replaceAll("°c", '');
      double value = double.parse(temp);
      return value;
    }
    return 0.0;
  }

    double lowestTemp() {
    Map<String, String>? caca = map['temp'];
    if (caca != null) {
      String temp = caca.values.reduce((value, element) => value.length < element.length ? value : element);
      temp = temp.replaceAll("°c", '');
      double value = double.parse(temp);
      return value;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 24,
        minY: lowestTemp(),
        maxY: highestTemp(),
        // gridData: FlGridData(

        // )

        lineBarsData: [
          LineChartBarData(
            spots: chartList(),
            color: Colors.blue,
            
          )
        ]

      )
    );
  }
}
