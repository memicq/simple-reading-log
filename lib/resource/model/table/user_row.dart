import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/util/unique_id_generator.dart';

class UserRow {
  final String userId;
  final String uid;
  final String? displayName;
  final String? email;
  final LoginAuthenticationType authenticationType;
  DateTime createdAt;
  DateTime updatedAt;

  UserRow({
    required this.userId,
    required this.uid,
    required this.displayName,
    required this.email,
    required this.authenticationType,
    required this.createdAt,
    required this.updatedAt,
  });

  static UserRow createNewUser(
    String uid,
    String? displayName,
    String? email,
    LoginAuthenticationType authenticationType,
  ) {
    String userId = UniqueIdGenerator().generateId();

    return UserRow(
      userId: userId,
      uid: uid,
      displayName: displayName,
      email: email,
      authenticationType: authenticationType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  UserRow.fromSnapshot(QueryDocumentSnapshot snapshot)
      : assert(snapshot.get("userId") != null),
        assert(snapshot.get("uid") != null),
        assert(snapshot.get("authenticationType") != null),
        assert(snapshot.get("createdAt") != null),
        assert(snapshot.get("updatedAt") != null),
        userId = snapshot.reference.id,
        uid = snapshot.get("uid"),
        displayName = snapshot.get("displayName"),
        email = snapshot.get("email"),
        authenticationType = LoginAuthenticationTypeExt.fromCode(
          snapshot.get("authenticationType"),
        ),
        createdAt = snapshot.get("createdAt").toDate(),
        updatedAt = snapshot.get("updatedAt").toDate();

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "authenticationType": authenticationType.code,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }

  @override
  String toString() => "UserRow<userId=$userId, email=$email>";
}
