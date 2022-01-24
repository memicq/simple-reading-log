import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_modal.dart';

class ReadingActivityRecordModalBottom extends StatelessWidget {
  ReadingActivityRecordModalBottom({Key? key}) : super(key: key);

  Future<void> recordActivity(
    BuildContext context,
    String userId,
    ReadingActivityRecordCubit _cubit,
  ) async {
    await _cubit.saveActivity(userId);
    ReadingActivityRecordModal.close(context);
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    ReadingActivityRecordCubit _readingActivityRecordCubit =
        context.read<ReadingActivityRecordCubit>();
    return Container(
      padding: const EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: TextButton(
        child: const Text("記録を追加"),
        onPressed: () => recordActivity(
          context,
          _sessionCubit.getCurrentUserId(),
          _readingActivityRecordCubit,
        ),
      ),
    );
  }
}
