import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/enum/book_timeline_item_type.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/resource/repository/book_timeline_item_repository.dart';
import 'package:simple_book_log/resource/repository/reading_activity_repository.dart';

class ReadingActivityRecordCubit extends Cubit<Map<BookRow, bool>> {
  ReadingActivityRecordCubit() : super({});

  final BookRepository _bookRepository = BookRepository();
  final ReadingActivityRepository _readingActivityRepository = ReadingActivityRepository();
  final BookTimelineItemRepository _bookTimelineItemRepository = BookTimelineItemRepository();

  DateTime selectedDate = DateTime.now();
  List<BookRow> booksAfterReading = [];
  Map<BookRow, bool> selectedBooks = {};

  Future<void> listByStatus(String userId) async {
    List<BookRow> readingBooks = await _bookRepository.listByStatus(userId, BookStatus.reading);
    List<BookRow> finishReadingBooks =
        await _bookRepository.listByStatus(userId, BookStatus.finishReading);
    booksAfterReading = readingBooks + finishReadingBooks;

    selectedBooks = Map.fromEntries(booksAfterReading.map((book) => MapEntry(book, false)));
    emit(selectedBooks);
  }

  Future<void> saveActivity(String userId) async {
    ReadingActivityRow _readingActivityRow =
        ReadingActivityRow.createNewReadingActivity(selectedDate);
    await _readingActivityRepository.create(userId, _readingActivityRow);

    List<BookRow> selectedBookRows =
        Map.fromEntries(selectedBooks.entries.where((entry) => entry.value)).keys.toList();

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
    selectedBooks.entries.where((entry) => entry.key.bookId == bookId).forEach((entry) {
      selectedBooks[entry.key] = !entry.value;
    });

    emit(selectedBooks);
  }
}
