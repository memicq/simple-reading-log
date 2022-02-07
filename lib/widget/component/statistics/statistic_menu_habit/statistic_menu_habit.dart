import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_cubit.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu/statistic_menu_card.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_habit/statistic_menu_habit_bottom.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_habit/statistic_menu_calendar.dart';
import 'package:simple_book_log/widget/component/statistics/statistic_menu_habit/statistic_menu_habit_item.dart';

class StatisticMenuHabit extends StatelessWidget {
  StatisticMenuHabit({
    Key? key,
  }) : super(key: key);

  static DateTime _lowerBoundDate = DateTime(1900, 1, 1);

  int _getDailyConsecutiveNumberUntilToday(
    Map<int, List<ReadingActivityRow>> dayActivities,
  ) {
    DateTime _now = DateTime.now();

    var dailyConsecutiveNumber = 0;

    for (var i = 0; i <= _now.difference(_lowerBoundDate).inDays; i += 1) {
      DateTime nDayBeforeToday = _now.subtract(Duration(days: i));
      bool hasEvent = dayActivities.containsKey(DateTimeUtil.dateKey(nDayBeforeToday));
      if (!hasEvent) break;
      dailyConsecutiveNumber += 1;
    }

    return dailyConsecutiveNumber;
  }

  int _getWeeklyConsecutiveNumberUntilToday(
    Map<int, List<ReadingActivityRow>> dayActivities,
  ) {
    DateTime _now = DateTime.now();

    var weeklyConsecutiveNumber = 0;

    for (var i = 0; i <= (_now.difference(_lowerBoundDate).inDays ~/ 7); i += 1) {
      DateTime _thisWeekStartDay = _now.subtract(Duration(days: _now.weekday + 7 * i));
      List<int> _thisWeekDateKeys = [
        for (var i = 0; i < 7; i++) DateTimeUtil.dateKey(_thisWeekStartDay.add(Duration(days: i)))
      ];

      bool hasEvent = _thisWeekDateKeys
          .map((dateKey) => dayActivities.containsKey(dateKey))
          .any((hasEvent) => hasEvent);
      if (!hasEvent) break;
      weeklyConsecutiveNumber += 1;
    }

    return weeklyConsecutiveNumber;
  }

  int _getMonthlyConsecutiveNumberUntilToday(
    Map<int, List<ReadingActivityRow>> dayActivities,
  ) {
    DateTime _now = DateTime.now();

    var monthlyConsecutiveNumber = 0;

    for (var i = 0; i <= (_now.difference(_lowerBoundDate).inDays ~/ 30); i += 1) {
      DateTime _thisMonthStartDay = DateTime(_now.year, _now.month - i);
      DateTime _thisMonthEndDay = DateTime(_now.year, _now.month - i + 1, 0);
      List<int> _thisMonthDateKeys = List<int>.generate(
        _thisMonthEndDay.day,
        (i) => DateTimeUtil.dateKey(
          DateTime(_thisMonthStartDay.year, _thisMonthStartDay.month, i + 1),
        ),
      );

      bool hasEvent = _thisMonthDateKeys
          .map((dateKey) => dayActivities.containsKey(dateKey))
          .any((hasEvent) => hasEvent);
      if (!hasEvent) break;
      monthlyConsecutiveNumber += 1;
    }

    return monthlyConsecutiveNumber;
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    ReadingActivityCubit _readingActivityCubit = context.read<ReadingActivityCubit>();

    return BlocBuilder<ReadingActivityCubit, List<ReadingActivityRow>>(
      bloc: _readingActivityCubit,
      builder: (context, activities) {
        Map<int, List<ReadingActivityRow>> dayActivities = groupBy(
          activities,
          (ReadingActivityRow activity) => DateTimeUtil.dateKey(activity.activityDate),
        );

        return StatisticMenuCard(
          title: "読書習慣",
          mainColor: _sessionCubit.getAccentColor(),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StatisticMenuHabitItem(
                        title: "連続月数",
                        value: _getMonthlyConsecutiveNumberUntilToday(dayActivities),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatisticMenuHabitItem(
                        title: "連続週数",
                        value: _getWeeklyConsecutiveNumberUntilToday(dayActivities),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatisticMenuHabitItem(
                        title: "連続日数",
                        value: _getDailyConsecutiveNumberUntilToday(dayActivities),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                StatisticMenuCalendar(),
                StatisticMenuHabitBottom(),
              ],
            ),
          ),
        );
      },
    );
  }
}
