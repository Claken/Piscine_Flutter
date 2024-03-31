import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final String y;
}

class ChartToday extends StatelessWidget {
  const ChartToday({
    super.key,
    required this.map,
  });

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

        return FlSpot(dhour, tempe);
      }
      return const FlSpot(0.0, 0.0);
    }));
    return list;
  }

  double highestTemp() {
    double temp = 0.0;
    double tmp = 0.0;
    String str = '';
    for (var v in map.values) {
      str = v['temp']!.replaceAll('°C', "");
      tmp = double.parse(str);
      if (temp < tmp) {
        temp = tmp;
      }
    }
    return temp;
  }

  double lowestTemp() {
    double temp = double.infinity;
    double tmp = 0.0;
    String str = '';
    for (var v in map.values) {
      str = v['temp']!.replaceAll('°C', "");
      tmp = double.parse(str);
      if (temp > tmp) {
        temp = tmp;
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 300,
        child: LineChart(LineChartData(
            minX: 0,
            maxX: 23,
            minY: lowestTemp(),
            maxY: highestTemp(),
            // gridData: FlGridData(
            //   show: true,
            //   getDrawingHorizontalLine:

            // )

            lineBarsData: [
              LineChartBarData(
                spots: chartList(),
                color: Colors.white,
              )
            ])));
  }
}
