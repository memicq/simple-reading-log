import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/bloc/statistic_menu_monthly_books_cubit.dart';
import 'package:simple_book_log/widget/component/statistics/statistics_template.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    DateTime _now = DateTime.now();
    DateTime _startThisMonth = DateTime(_now.year, _now.month, 1);
    DateTime _endThisMonth = DateTime(_now.year, _now.month + 1, 1).subtract(Duration(days: 1));

    return MultiBlocProvider(
      providers: [
        BlocProvider<ReadingActivityCubit>(
          create: (context) => ReadingActivityCubit()..list(_sessionCubit.getCurrentUserId()),
        ),
        BlocProvider<ReadingActivityRecordCubit>(
          create: (context) =>
              ReadingActivityRecordCubit()..initialize(userId: _sessionCubit.getCurrentUserId()),
        ),
        BlocProvider<StatisticMenuMonthlyBooksCubit>(
          create: (context) => StatisticMenuMonthlyBooksCubit()
            ..initialize(
              _sessionCubit.getCurrentUserId(),
              _startThisMonth,
              _endThisMonth,
            ),
        )
      ],
      child: StatisticsTemplate(),
    );
  }

  static void open(
    BuildContext context, {
    void Function()? callback,
  }) {
    void Function() _callback = (callback != null) ? callback : () {};
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => const StatisticsScreen(),
            fullscreenDialog: true,
          ),
        )
        .then(
          (value) => _callback(),
        );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
