import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/repository/book_timeline_item_repository.dart';

class BookshelfDetailTimelineCubit extends Cubit<List<BookTimelineItemRow>> {
  BookshelfDetailTimelineCubit() : super(List.empty());

  final BookTimelineItemRepository _bookTimelineItemRepository = BookTimelineItemRepository();

  List<BookTimelineItemRow> sortedTimelineItems = List.empty();

  Future<void> listAll(String userId, String bookId) async {
    List<BookTimelineItemRow> timelineItems =
        await _bookTimelineItemRepository.list(userId, bookId);
    timelineItems.sort((a, b) => (a.createdAt.isBefore(b.createdAt) ? 1 : -1));
    sortedTimelineItems = timelineItems;
    emit(sortedTimelineItems);
  }
}
