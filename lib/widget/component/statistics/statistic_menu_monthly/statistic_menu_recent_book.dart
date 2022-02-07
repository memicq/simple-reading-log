import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/statistic_menu_monthly_books_cubit.dart';
import 'package:simple_book_log/resource/model/state/statistic_menu_monthly_books_cubit_state.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu/statistic_menu_card.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_monthly/statistic_menu_bar_chart.dart';

class StatisticMenuMonthly extends StatelessWidget {
  StatisticMenuMonthly({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    StatisticMenuMonthlyBooksCubit _monthlyBooksCubit =
        context.read<StatisticMenuMonthlyBooksCubit>();
    return BlocBuilder<StatisticMenuMonthlyBooksCubit, StatisticMenuMonthlyBooksCubitState>(
      bloc: _monthlyBooksCubit,
      builder: (context, state) {
        List<charts.Series<DateTime, String>> series = [
          charts.Series(
            id: "適当なid",
            data: state.readingBookCountData.keys.toList(),
            domainFn: (date, _) => date.day.toString(),
            measureFn: (date, _) => state.readingBookCountData[date],
            colorFn: (_1, _2) => charts.Color.fromHex(
              code: charts.ColorUtil.fromDartColor(Colors.cyan.shade200).hexString,
            ),
          )
        ];

        return StatisticMenuCard(
          title: "月の読書量",
          mainColor: _sessionCubit.getAccentColor(),
          child: StatisticMenuBarChart(
            series: series,
          ),
        );
      },
    );
  }
}
