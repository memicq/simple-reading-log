import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/resource/repository/repository_base.dart';

class ReadingActivityRepository extends RepositoryBase<ReadingActivityRow> {
  static String COLLECTION_NAME = 'reading_activities';

  @override
  Future<void> create(String userId, ReadingActivityRow row) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection(COLLECTION_NAME)
        .doc(row.readingActivityId)
        .set(row.toMap());
  }

  Future<ReadingActivityRow?> findByDate(String userId, DateTime date) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot = await _db
        .collection('users')
        .doc(userId)
        .collection(COLLECTION_NAME)
        .where("activityDate", isEqualTo: Timestamp.fromDate(date))
        .get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final ReadingActivityRow? _readingActivityRow =
        _documentSnapshot.map((snapshot) => ReadingActivityRow.fromSnapshot(snapshot)).first;
    return _readingActivityRow;
  }

  @override
  Future<List<ReadingActivityRow>> list(String userId) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot =
        await _db.collection('users').doc(userId).collection(COLLECTION_NAME).get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final List<ReadingActivityRow> _readingActivityRows =
        _documentSnapshot.map((snapshot) => ReadingActivityRow.fromSnapshot(snapshot)).toList();
    return _readingActivityRows;
  }

  @override
  Future<void> delete(String userId, String documentId) async {
    final _db = FirebaseFirestore.instance;
    await _db.collection('users').doc(userId).collection(COLLECTION_NAME).doc(documentId).delete();
  }

  @override
  Future<void> update(String userId, ReadingActivityRow updatedRow) async {
    final _db = FirebaseFirestore.instance;
    await _db
        .collection('users')
        .doc(userId)
        .collection(COLLECTION_NAME)
        .doc(updatedRow.readingActivityId)
        .update(updatedRow.toMap());
  }
}
