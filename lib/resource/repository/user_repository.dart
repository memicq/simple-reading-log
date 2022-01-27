import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';

class UserRepository {
  Future<void> create(UserRow user) async {
    final _db = FirebaseFirestore.instance;
    await _db.collection('users').doc(user.userId).set(user.toMap());
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
}
