import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/state/statistic_menu_monthly_books_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/util/datetime_util.dart';

class StatisticMenuMonthlyBooksCubit extends Cubit<StatisticMenuMonthlyBooksCubitState> {
  StatisticMenuMonthlyBooksCubit() : super(StatisticMenuMonthlyBooksCubitState.initialState);

  final BookRepository _bookRepository = BookRepository();

  StatisticMenuMonthlyBooksCubitState _state = StatisticMenuMonthlyBooksCubitState.initialState;

  Future<void> initialize(String userId, DateTime start, DateTime end) async {
    Map<BookRow, DateTime> readBooks = await _bookRepository.listFinishedBook(userId, start, end);

    int dayDiff = end.difference(start).inDays;
    DateTime startDate = DateTime(start.year, start.month, start.day);

    Map<DateTime, int> dateCount = {};
    for (int i = 0; i <= dayDiff; i++) {
      DateTime _date = startDate.add(Duration(days: i));
      int count = readBooks.values
          .where((date) => DateTimeUtil.dateKey(date) == DateTimeUtil.dateKey(_date))
          .length;
      dateCount[_date] = count;
    }

    _state = _state.copyWith(readingBookCountData: dateCount);
    emit(_state);
  }
}
