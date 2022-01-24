import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu/statistic_menu_card.dart';

class StatisticMenuAccumulation extends StatelessWidget {
  const StatisticMenuAccumulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatisticMenuCard(
      title: "すべての読書量",
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("aaa"),
      ),
    );
  }
}
