import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/enum/book_timeline_item_type.dart';
import 'package:simple_book_log/util/unique_id_generator.dart';

class BookTimelineItemRow {
  final String bookTimelineItemId;
  final BookTimelineItemType bookTimelineItemType;
  final BookStatus? bookStatus;

  final DateTime createdAt;
  final DateTime updatedAt;

  BookTimelineItemRow({
    required this.bookTimelineItemId,
    required this.bookTimelineItemType,
    required this.bookStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  static BookTimelineItemRow createNewBookTimelineItem({
    required BookTimelineItemType bookTimelineItemType,
    BookStatus? bookStatus,
  }) {
    String bookTimelineItemId = UniqueIdGenerator().generateId();

    return BookTimelineItemRow(
      bookTimelineItemId: bookTimelineItemId,
      bookTimelineItemType: bookTimelineItemType,
      bookStatus: bookStatus,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  BookTimelineItemRow.fromSnapshot(QueryDocumentSnapshot snapshot)
      : assert(snapshot.get("bookTimelineItemType") != null),
        assert(snapshot.get("createdAt") != null),
        assert(snapshot.get("updatedAt") != null),
        bookTimelineItemId = snapshot.reference.id,
        bookTimelineItemType = BookTimelineItemTypeExt.fromCode(
          snapshot.get("bookTimelineItemType"),
        ),
        bookStatus = snapshot.get("bookStatus") != null
            ? BookStatusExt.fromCode(snapshot.get("bookStatus"))
            : null,
        createdAt = snapshot.get("createdAt").toDate(),
        updatedAt = snapshot.get("updatedAt").toDate();

  Map<String, dynamic> toMap() {
    return {
      "bookTimelineItemId": bookTimelineItemId,
      "bookTimelineItemType": bookTimelineItemType.code,
      "bookStatus": bookStatus?.code,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  String createTimelineString() {
    switch (bookTimelineItemType) {
      case BookTimelineItemType.addBook:
        return "「${bookStatus!.japaneseName}」として本を追加";
      case BookTimelineItemType.changeStatus:
        return "「${bookStatus!.japaneseName}」に変更";
      case BookTimelineItemType.readBook:
        return "読書";
      default:
        return "";
    }
  }

  @override
  String toString() => "BookTimelineItemRow<bookTimelineItemId=$bookTimelineItemId>";
}
