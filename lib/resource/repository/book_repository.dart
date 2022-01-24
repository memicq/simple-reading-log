import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/repository/repository_base.dart';

class BookRepository extends RepositoryBase<BookRow> {
  @override
  Future<void> create(String userId, BookRow book) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .doc(book.bookId)
        .set(book.toMap());
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

  Future<List<BookRow>> listByStatus(String userId, BookStatus status) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('books')
        .where('status', isEqualTo: status.code!)
        .get();
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
        .update(updatedRow.toMap());
  }
}
