import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/view/book_with_period.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';

class StatisticMenuRecentBookCubit extends Cubit<List<BookWithPeriod>> {
  StatisticMenuRecentBookCubit() : super(List.empty());

  final BookRepository _bookRepository = BookRepository();

  Future<void> listRecent({required String userId}) async {
    List<BookWithPeriod> bookWithPeriods = await _bookRepository.listBookWithPeriod(userId);

    emit(bookWithPeriods);
  }
}
