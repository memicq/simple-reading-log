import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_cubit.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_modal.dart';

class StatisticMenuHabitBottom extends StatelessWidget {
  final DateTime _now = DateTime.now();

  StatisticMenuHabitBottom({
    Key? key,
  }) : super(key: key);

  DateTime getToday() {
    return DateTime(_now.year, _now.month, _now.day);
  }

  Future<void> createReadingActivity(
    String userId,
    ReadingActivityCubit _cubit,
  ) async {
    ReadingActivityRow _activity = ReadingActivityRow.createNewReadingActivity(getToday());
    await _cubit.create(userId, _activity);
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    ReadingActivityCubit _readingActivityCubit = context.read<ReadingActivityCubit>();

    String userId = _sessionCubit.getCurrentUserId();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: const Text("読書記録を追加する"),
        onPressed: () => ReadingActivityRecordModal.open(
          context,
          initialDate: getToday(),
        ),
      ),
    );
  }
}
