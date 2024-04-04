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
        height: 240,
        child: LineChart(LineChartData(
            minX: 0,
            maxX: 23,
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
                  reservedSize: 50,
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
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    var str = value.toInt().toString();
                    str = "${str}h";
                    if (str == "23h") {
                      str = '';
                    }
                    return Text(str,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white));
                  },
                ))),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.white, width: 1),
            ),
            gridData: FlGridData(
              getDrawingHorizontalLine: (value) {
                return const FlLine(color: Colors.white, strokeWidth: 0.25, dashArray: [7]);
              },
              getDrawingVerticalLine: (value) {
                return const FlLine(color: Colors.white, strokeWidth: 0.25, dashArray: [7]);
              })
            ,
            lineBarsData: [
              LineChartBarData(
                spots: chartList(),
                color: Colors.orange,
              )
            ])));
  }
}
