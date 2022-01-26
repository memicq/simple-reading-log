import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_cubit.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:simple_book_log/widget/component/common/event_calendar.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_modal.dart';
import "package:collection/collection.dart";

class StatisticMenuCalendar extends StatefulWidget {
  const StatisticMenuCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StatisticMenuCalendarState();
}

class StatisticMenuCalendarState extends State<StatisticMenuCalendar> {
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

        return EventCalendar(
          initialFocusedDate: DateTime.now(),
          dayActivities: dayActivities,
          onDayLongPressed: (selectedDate, focusedDate) {
            if (selectedDate.isAfter(DateTime.now())) return;

            ReadingActivityRecordModal.open(
              context,
              initialDate: selectedDate,
              callback: () => _readingActivityCubit.list(_sessionCubit.getCurrentUserId()),
            );
          },
        );
      },
    );
  }
}
