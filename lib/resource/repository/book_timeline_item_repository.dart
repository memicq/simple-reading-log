import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';

class BookTimelineItemRepository {
  Future<void> create(String userId, String bookId, BookTimelineItemRow timelineItem) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(bookId)
        .collection('book_timeline_items')
        .doc(timelineItem.bookTimelineItemId)
        .set(timelineItem.toMap());
  }

  Future<List<BookTimelineItemRow>> list(
    String userId,
    String bookId,
  ) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(bookId)
        .collection('book_timeline_items')
        .get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final List<BookTimelineItemRow> _timelineItemRows =
        _documentSnapshot.map((snapshot) => BookTimelineItemRow.fromSnapshot(snapshot)).toList();
    return _timelineItemRows;
  }

  Future<void> delete(String userId, String bookId, String documentId) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(bookId)
        .collection('book_timeline_items')
        .doc(documentId)
        .delete();
  }

  Future<void> update(String userId, String bookId, BookTimelineItemRow updatedRow) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(bookId)
        .collection('book_timeline_items')
        .doc(updatedRow.bookTimelineItemId)
        .update(updatedRow.toMap());
  }
}
