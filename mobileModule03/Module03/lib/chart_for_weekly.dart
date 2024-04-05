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
        width: 300,
        height: 200,
        child: LineChart(LineChartData(
            minX: 0,
            maxX: 6,
            minY: lowestTemp(),
            maxY: highestTemp(),
            titlesData: FlTitlesData(
                show: true,
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 30,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String degree = "";
                    if (value - value.toInt() == 0) {
                      degree = "${value.toInt()}°C";
                    }
                    return Text(
                      degree,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    );
                  },
                )),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String date = "";
                    String index = value.toInt().toString();

                    if (map[index] != null) {
                      if (map[index]?['date'] != null) {
                        date = map[index]?['date'] ?? '';
                        if (date != '') {
                          date = date.substring(5);
                        }
                      }
                    }
                    return Text(date,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white));
                  },
                ))),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.white, width: 1),
            ),
            gridData: FlGridData(getDrawingHorizontalLine: (value) {
              return const FlLine(
                  color: Colors.white, strokeWidth: 0.25, dashArray: [7]);
            }, getDrawingVerticalLine: (value) {
              return const FlLine(
                  color: Colors.white, strokeWidth: 0.25, dashArray: [7]);
            }),
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
