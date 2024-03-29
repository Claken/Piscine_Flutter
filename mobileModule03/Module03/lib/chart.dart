import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final String y;
}

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.mapType,
    required this.map,
  });

  final String mapType;
  final Map<String, Map<String, String>> map;

  List<ChartData> chartList() {
    List<ChartData> list = [];

    list.addAll(map.entries.map((entry) {
      String? temp = entry.value['temp'];
      String? hour = entry.value['hour'];

      if (temp != null && hour != null) {
        temp = temp.replaceAll('°C', '');
        double tempe = double.parse(temp);

        return ChartData(tempe, hour);
      }
      return ChartData(0.0, '');
    }));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(series: <CartesianSeries>[
      // Renders spline chart
      SplineSeries<ChartData, int>(
          dataSource: chartList(),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y)
    ]))));
  }
}
