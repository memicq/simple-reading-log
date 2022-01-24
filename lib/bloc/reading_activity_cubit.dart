import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/resource/repository/reading_activity_repository.dart';

class ReadingActivityCubit extends Cubit<List<ReadingActivityRow>> {
  ReadingActivityCubit() : super(List.empty());

  final ReadingActivityRepository _readingActivityRepository = ReadingActivityRepository();

  List<ReadingActivityRow> _activities = List.empty();

  Future<void> list(String userId) async {
    _activities = await _readingActivityRepository.list(userId);
    emit(_activities);
  }

  Future<void> create(String userId, ReadingActivityRow row) async {
    await _readingActivityRepository.create(userId, row);
    _activities = await _readingActivityRepository.list(userId);
    emit(_activities);
  }

  Future<void> delete(String userId, DateTime date) async {
    ReadingActivityRow? _readingActivityRow =
        await _readingActivityRepository.findByDate(userId, date);
    if (_readingActivityRow != null) {
      await _readingActivityRepository.delete(userId, _readingActivityRow.readingActivityId);
      _activities = await _readingActivityRepository.list(userId);
      emit(_activities);
    }
  }
}
