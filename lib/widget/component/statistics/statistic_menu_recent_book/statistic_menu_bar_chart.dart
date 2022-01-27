import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class StatisticMenuBarChart extends StatelessWidget {
  final List<charts.Series<DateTime, String>> series;

  const StatisticMenuBarChart({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(minHeight: 200, maxHeight: 400),
      child: SizedBox(
        height: 200,
        child: charts.BarChart(series),
      ),
    );
  }
}
