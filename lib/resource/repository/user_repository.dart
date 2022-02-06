import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/resource/repository/reading_activity_repository.dart';

class UserRepository {
  BookRepository _bookRepository = BookRepository();
  ReadingActivityRepository _readingActivityRepository = ReadingActivityRepository();

  Future<void> create(UserRow user) async {
    final _db = FirebaseFirestore.instance;
    await _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<void> update(UserRow user) async {
    final _db = FirebaseFirestore.instance;
    await _db.collection('users').doc(user.userId).update(user.toMap());
  }

  Future<UserRow?> findBy(String email) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot =
        await _db.collection('users').where("email", isEqualTo: email).get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final UserRow? _userRow = _documentSnapshot.map((e) => UserRow.fromSnapshot(e)).firstOrNull;
    return _userRow;
  }

  Future<UserRow?> findByUid(String uid) async {
    final _db = FirebaseFirestore.instance;
    final QuerySnapshot _querySnapshot =
        await _db.collection('users').where("uid", isEqualTo: uid).get();
    final List<QueryDocumentSnapshot> _documentSnapshot = _querySnapshot.docs;
    final UserRow? _userRow = _documentSnapshot.map((e) => UserRow.fromSnapshot(e)).firstOrNull;
    return _userRow;
  }

  Future<void> delete(String userId) async {
    final _db = FirebaseFirestore.instance;
    DocumentReference _userRef = _db.collection('users').doc(userId);

    // books を削除する
    QuerySnapshot _bookQs = await _userRef.collection('books').get();
    await Future.wait(
      _bookQs.docs.map((qds) async {
        await _bookRepository.delete(userId, qds.id);
      }),
    );

    // reading_activities を削除する
    QuerySnapshot _readingActivityQs = await _userRef.collection('reading_activities').get();
    await Future.wait(
      _readingActivityQs.docs.map((qds) async {
        await _readingActivityRepository.delete(userId, qds.id);
      }),
    );

    await _userRef.delete();
  }
}
