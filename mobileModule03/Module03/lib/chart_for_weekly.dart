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
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        height: 300,
        child: LineChart(LineChartData(
            minX: 0,
            maxX: 6,
            minY: lowestTemp(),
            maxY: highestTemp(),
            titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 50,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text("$value°C", style: const TextStyle(fontSize: 14, ),);
                  },
                )),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value) {
                      case 0.0:
                        return const Text('MON');
                      case 1.0:
                        return const Text('TUE');
                      case 2.0:
                        return const Text('WED');
                      case 3.0:
                        return const Text('THU');
                      case 4.0:
                        return const Text('FRY');
                      case 5.0:
                        return const Text('SAT');
                      case 6.0:
                        return const Text('SUN');
                    }
                    return const Text('');
                  },
                ))),
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
