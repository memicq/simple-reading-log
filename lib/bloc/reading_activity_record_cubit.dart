import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/enum/book_timeline_item_type.dart';
import 'package:simple_book_log/resource/model/state/reading_activity_record_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/resource/repository/book_timeline_item_repository.dart';
import 'package:simple_book_log/resource/repository/reading_activity_repository.dart';

class ReadingActivityRecordCubit extends Cubit<ReadingActivityRecordCubitState> {
  ReadingActivityRecordCubit() : super(ReadingActivityRecordCubitState.initialState);

  final BookRepository _bookRepository = BookRepository();
  final ReadingActivityRepository _readingActivityRepository = ReadingActivityRepository();
  final BookTimelineItemRepository _bookTimelineItemRepository = BookTimelineItemRepository();

  ReadingActivityRecordCubitState _state = ReadingActivityRecordCubitState.initialState;

  Future<void> initialize({
    required String userId,
    DateTime? initialDate,
    BookRow? onlyBook,
  }) async {
    DateTime _initialDate = initialDate ?? DateTime.now();

    Map<BookRow, bool> selectedBooks;
    if (onlyBook != null) {
      selectedBooks = {onlyBook: true};
    } else {
      List<BookRow> readingBooks = await _bookRepository.listByStatus(userId, BookStatus.reading);
      List<BookRow> finishReadingBooks =
          await _bookRepository.listByStatus(userId, BookStatus.finishReading);
      List<BookRow> booksAfterReading = readingBooks + finishReadingBooks;
      selectedBooks = Map.fromEntries(
        booksAfterReading.map((book) => MapEntry(book, false)),
      );
    }

    _state = _state.copyWith(selectedDate: _initialDate, selectedBooks: selectedBooks);
    emit(_state);
  }

  Future<void> saveActivity(String userId) async {
    ReadingActivityRow? _readingActivityRow =
        await _readingActivityRepository.findByDate(userId, _state.selectedDate);

    if (_readingActivityRow == null) {
      ReadingActivityRow _readingActivityRow =
          ReadingActivityRow.createNewReadingActivity(_state.selectedDate);
      await _readingActivityRepository.create(userId, _readingActivityRow);
    }

    List<BookRow> selectedBookRows =
        Map.fromEntries(_state.selectedBooks.entries.where((entry) => entry.value)).keys.toList();

    await Future.wait(
      selectedBookRows.map((book) async {
        BookTimelineItemRow _bookTimelineItemRow = BookTimelineItemRow.createNewBookTimelineItem(
          bookTimelineItemType: BookTimelineItemType.readBook,
        );
        await _bookTimelineItemRepository.create(userId, book.bookId, _bookTimelineItemRow);
      }),
    );
  }

  Future<void> toggleBookSelection(String bookId) async {
    Map<BookRow, bool> selectedBooks = _state.selectedBooks;

    selectedBooks.entries.where((entry) => entry.key.bookId == bookId).forEach((entry) {
      selectedBooks[entry.key] = !entry.value;
    });

    _state = _state.copyWith(selectedBooks: selectedBooks);
    emit(_state);
  }
}
