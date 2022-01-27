import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/widget/component/common/column_spacer.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_accumulation/statistic_menu_accumulation.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_habit/statistic_menu_habit.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_recent_book/statistic_menu_recent_book.dart';

class StatisticsTemplate extends StatelessWidget {
  StatisticsTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadingActivityRecordCubit _statisticsBookCubit = context.read<ReadingActivityRecordCubit>();

    return TemplateScaffold(
      title: "記録",
      body: ListView(
        children: [
          StatisticMenuHabit(),
          const ColumnSpacer(),
          StatisticMenuRecentBook(),
          // const ColumnSpacer(),
          // const StatisticMenuAccumulation(),
        ],
      ),
    );
  }
}
