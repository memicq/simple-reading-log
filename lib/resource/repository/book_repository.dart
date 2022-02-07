import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/model/table/book_timeline_item_row.dart';
import 'package:simple_book_log/resource/model/view/book_with_period.dart';
import 'package:simple_book_log/resource/repository/repository_base.dart';

import "package:collection/collection.dart";

class BookRepository extends RepositoryBase<BookRow> {
  @override
  Future<void> create(String userId, BookRow book) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(book.bookId)
        .set(book.toMap(false));
  }

  @override
  Future<void> delete(String userId, String documentId) async {
    final _db = FirebaseFirestore.instance;
    DocumentReference _book =
        _db.collection('users').doc(userId).collection('books').doc(documentId);

    QuerySnapshot timelineItemsQs = await _book.collection('book_timeline_items').get();
    await Future.wait(
      timelineItemsQs.docs.map((qds) async {
        await qds.reference.delete();
      }),
    );
    await _book.delete();
  }

  @override
  Future<List<BookRow>> list(String userId) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot =
        await _db.collection('users').doc(userId).collection('books').get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final List<BookRow> _bookRows =
        _documentSnapshot.map((snapshot) => BookRow.fromSnapshot(snapshot)).toList();
    return _bookRows;
  }

  @override
  Future<void> update(String userId, BookRow updatedRow) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(updatedRow.bookId)
        .update(updatedRow.toMap(true));
  }

  Future<List<BookWithPeriod>> listBookWithPeriod(String userId) async {
    final _db = FirebaseFirestore.instance;
    final bookQs = await _db.collection('users').doc(userId).collection('books').get();
    final bookWithPeriods = await Future.wait(
      bookQs.docs.map(
        (qds) async {
          final finishEvent = await qds.reference
              .collection('book_timeline_items')
              .where(
                'bookStatus',
                isEqualTo: BookStatus.finishReading.code,
              )
              .orderBy('createdAt', descending: true)
              .limit(1)
              .get();

          final startEvent = await qds.reference
              .collection('book_timeline_items')
              .where(
                'bookStatus',
                isEqualTo: BookStatus.reading.code,
              )
              .orderBy('createdAt', descending: true)
              .limit(1)
              .get();

          if (finishEvent.docs.isEmpty) return null;
          QueryDocumentSnapshot finishEventQs = finishEvent.docs.single;
          QueryDocumentSnapshot? startEventQs = startEvent.docs.singleOrNull;

          BookTimelineItemRow _finishTI = BookTimelineItemRow.fromSnapshot(finishEventQs);
          BookTimelineItemRow? _startTI =
              startEventQs == null ? null : BookTimelineItemRow.fromSnapshot(startEventQs);
          return BookWithPeriod(
            bookRow: BookRow.fromSnapshot(qds),
            startDate: _startTI?.createdAt,
            endDate: _finishTI.createdAt,
          );
        },
      ),
    );

    return bookWithPeriods.whereType<BookWithPeriod>().toList();
  }

  Future<Map<BookRow, DateTime>> listFinishedBook(
      String userId, DateTime start, DateTime end) async {
    final _db = FirebaseFirestore.instance;
    final bookQs = await _db.collection('users').doc(userId).collection('books').get();
    final books = await Future.wait(
      bookQs.docs.map(
        (qds) async {
          final bookTimelineQs = await qds.reference
              .collection('book_timeline_items')
              .where('bookStatus', isEqualTo: BookStatus.finishReading.code)
              .orderBy('createdAt', descending: true)
              .get();

          if (bookTimelineQs.docs.isEmpty) return null;
          QueryDocumentSnapshot bookTimelineQds = bookTimelineQs.docs.single;

          BookTimelineItemRow _timelineItem = BookTimelineItemRow.fromSnapshot(bookTimelineQds);
          if (start.isBefore(_timelineItem.createdAt) && end.isAfter(_timelineItem.createdAt)) {
            return MapEntry(BookRow.fromSnapshot(qds), _timelineItem.createdAt);
          }
        },
      ),
    );

    return Map.fromEntries(books.where((entry) => entry != null).map((entry) => entry!));
  }
}
