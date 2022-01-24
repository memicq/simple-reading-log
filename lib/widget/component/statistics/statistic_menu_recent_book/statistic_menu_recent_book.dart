import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu/statistic_menu_card.dart';

class StatisticMenuRecentBook extends StatelessWidget {
  StatisticMenuRecentBook({Key? key}) : super(key: key);

  List<String> data = ["aa", "bb", "cc"];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<String, String>> series = [
      charts.Series(
        id: "適当なid",
        data: data,
        domainFn: (_1, _2) => _1,
        measureFn: (_1, _2) => 12,
        colorFn: (_1, _2) => charts.Color.fromHex(
          code: charts.ColorUtil.fromDartColor(Colors.cyan.shade200).hexString,
        ),
      )
    ];

    return StatisticMenuCard(
      title: "最近の読書量",
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(minHeight: 200, maxHeight: 400),
        child: SizedBox(
          height: 200,
          child: charts.BarChart(series),
        ),
      ),
    );
  }
}
