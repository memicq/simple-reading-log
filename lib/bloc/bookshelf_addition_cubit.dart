import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/enum/book_timeline_item_type.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/resource/repository/book_timeline_item_repository.dart';

class BookshelfAdditionCubit extends Cubit<bool> {
  BookshelfAdditionCubit() : super(false);

  final BookRepository _bookRepository = BookRepository();
  final BookTimelineItemRepository _bookTimelineItemRepository = BookTimelineItemRepository();

  Future<void> create(String userId, BookRow bookRow) async {
    await _bookRepository.create(userId, bookRow);

    BookTimelineItemRow _bookTimelineItemRow = BookTimelineItemRow.createNewBookTimelineItem(
      bookTimelineItemType: BookTimelineItemType.addBook,
      bookStatus: bookRow.status,
    );
    await _bookTimelineItemRepository.create(userId, bookRow.bookId, _bookTimelineItemRow);
  }
}
