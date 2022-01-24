import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/enum/book_timeline_item_type.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/resource/repository/book_timeline_item_repository.dart';

class BookshelfItemDetailCubit extends Cubit<BookRow> {
  BookRow bookRow;
  BookshelfItemDetailCubit({required this.bookRow}) : super(bookRow);

  final BookRepository _bookRepository = BookRepository();
  final BookTimelineItemRepository _bookTimelineItemRepository = BookTimelineItemRepository();

  Future<void> updateStatus(String userId, BookStatus newStatus) async {
    BookRow newBookRow = bookRow.copyWith(newStatus: newStatus);
    await _bookRepository.update(userId, newBookRow);
    BookTimelineItemRow _bookTimelineItemRow = BookTimelineItemRow.createNewBookTimelineItem(
      bookTimelineItemType: BookTimelineItemType.changeStatus,
      bookStatus: newStatus,
    );
    await _bookTimelineItemRepository.create(userId, bookRow.bookId, _bookTimelineItemRow);
    emit(newBookRow);
  }

  Future<void> updateMemo(String userId, String memo) async {
    BookRow newBookRow = bookRow.copyWith(newMemo: memo);
    await _bookRepository.update(userId, newBookRow);
    emit(newBookRow);
  }

  Future<void> deleteBook(String userId, String bookId) async {
    await _bookRepository.delete(userId, bookId);
  }
}
