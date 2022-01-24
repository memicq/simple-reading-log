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
  Future<void> _createReadingActivity(
    String userId,
    DateTime date,
    ReadingActivityCubit _cubit,
  ) async {
    ReadingActivityRow _activity = ReadingActivityRow.createNewReadingActivity(date);
    await _cubit.create(userId, _activity);
    ReadingActivityRecordModal.close(context);
  }

  Future<void> _deleteReadingActivity(
    String userId,
    DateTime date,
    ReadingActivityCubit _cubit,
  ) async {
    await _cubit.delete(userId, date);
    ReadingActivityRecordModal.close(context);
  }

  void _onDayLongPressed(
    DateTime selectedDate,
    DateTime focusedDate,
    Map<int, List<ReadingActivityRow>> activities,
    String userId,
    ReadingActivityCubit readingActivityCubit,
  ) {
    if (selectedDate.isAfter(DateTime.now())) return;

    void Function() _onPressed;

    if (activities.containsKey(DateTimeUtil.dateKey(selectedDate))) {
      // _onPressed = () => _deleteReadingActivity(
      //       userId,
      //       selectedDate,
      //       readingActivityCubit,
      //     );
    } else {
      _onPressed = () => _createReadingActivity(
            userId,
            selectedDate,
            readingActivityCubit,
          );
    }

    ReadingActivityRecordModal.open(
      context,
      initialDate: selectedDate,
    );
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

        return EventCalendar(
          initialFocusedDate: DateTime.now(),
          dayActivities: dayActivities,
          onDayLongPressed: (selectedDate, focusedDate) {
            _onDayLongPressed(
              selectedDate,
              focusedDate,
              dayActivities,
              _sessionCubit.getCurrentUserId(),
              _readingActivityCubit,
            );
          },
        );
      },
    );
  }
}
