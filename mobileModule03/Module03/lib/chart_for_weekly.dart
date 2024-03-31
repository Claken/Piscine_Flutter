import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final String y;
}

class ChartWeek extends StatelessWidget {
  const ChartWeek({
    super.key,
    required this.map,
  });

  final Map<String, Map<String, String>> map;

  List<FlSpot> chartListMin() {
    List<FlSpot> list = [];
    double i = 0.0;

    for (var v in map.values) {
      String? temp = v['min'];

      if (temp != null) {
        temp = temp.replaceAll('°C', '');
        double tempe = double.parse(temp);
        list.add(FlSpot(i, tempe));
      } else {
        list.add(const FlSpot(0.0, 0.0));
      }
      i = i + 1.0;
    }
    return list;
  }

  List<FlSpot> chartListMax() {
    List<FlSpot> list = [];
    double i = 0.0;

    for (var v in map.values) {
      String? temp = v['max'];

      if (temp != null) {
        temp = temp.replaceAll('°C', '');
        double tempe = double.parse(temp);
        list.add(FlSpot(i, tempe));
      } else {
        list.add(const FlSpot(0.0, 0.0));
      }
      i = i + 1.0;
    }
    return list;
  }

  double highestTemp() {
    double temp = 0.0;
    double tmp = 0.0;
    String str = '';
    for (var v in map.values) {
      str = v['max']!.replaceAll('°C', "");
      tmp = double.parse(str);
      if (temp < tmp) {
        temp = tmp;
      }
    }
    debugPrint('temp high $temp');
    return temp;
  }

  double lowestTemp() {
    double temp = double.infinity;
    double tmp = 0.0;
    String str = '';
    for (var v in map.values) {
      str = v['min']!.replaceAll('°C', "");
      tmp = double.parse(str);
      if (temp > tmp) {
        temp = tmp;
      }
    }
    debugPrint('temp low $temp');
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 300,
        child: LineChart(LineChartData(
            minX: 0,
            maxX: 6,
            minY: lowestTemp(),
            maxY: highestTemp(),
            // gridData: FlGridData(
            //   show: true,
            //   getDrawingHorizontalLine:

            // )

            lineBarsData: [
              LineChartBarData(
                spots: chartListMin(),
                color: Colors.blue,
              ),
               LineChartBarData(
                spots: chartListMax(),
                color: Colors.orange,
              )
            ])));
  }
}
