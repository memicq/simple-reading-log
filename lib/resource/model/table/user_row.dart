import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/util/unique_id_generator.dart';

class UserRow {
  final String userId;
  final String uid;
  final String? displayName;
  final String? email;
  final LoginAuthenticationType authenticationType;
  final bool isAdvertisementEnabled;
  DateTime createdAt;
  DateTime updatedAt;

  UserRow({
    required this.userId,
    required this.uid,
    required this.displayName,
    required this.email,
    required this.authenticationType,
    required this.isAdvertisementEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  static UserRow createNewUser({
    required String uid,
    required LoginAuthenticationType authenticationType,
    String? displayName,
    String? email,
    bool? isAdvertisementEnabled,
  }) {
    String userId = UniqueIdGenerator().generateId();

    return UserRow(
      userId: userId,
      uid: uid,
      displayName: displayName,
      email: email,
      authenticationType: authenticationType,
      isAdvertisementEnabled: isAdvertisementEnabled ?? true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  UserRow copyWith({
    String? uid,
    String? displayName,
    String? email,
    LoginAuthenticationType? authenticationType,
    bool? isAdvertisementEnabled,
  }) {
    return UserRow(
      userId: userId,
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      authenticationType: authenticationType ?? this.authenticationType,
      isAdvertisementEnabled: isAdvertisementEnabled ?? this.isAdvertisementEnabled,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserRow.fromSnapshot(QueryDocumentSnapshot snapshot)
      : assert(snapshot.get("userId") != null),
        assert(snapshot.get("uid") != null),
        assert(snapshot.get("authenticationType") != null),
        assert(snapshot.get("isAdvertisementEnabled") != null),
        assert(snapshot.get("createdAt") != null),
        assert(snapshot.get("updatedAt") != null),
        userId = snapshot.reference.id,
        uid = snapshot.get("uid"),
        displayName = snapshot.get("displayName"),
        email = snapshot.get("email"),
        authenticationType = LoginAuthenticationTypeExt.fromCode(
          snapshot.get("authenticationType"),
        ),
        isAdvertisementEnabled = snapshot.get("isAdvertisementEnabled"),
        createdAt = snapshot.get("createdAt").toDate(),
        updatedAt = snapshot.get("updatedAt").toDate();

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "authenticationType": authenticationType.code,
      "isAdvertisementEnabled": isAdvertisementEnabled,
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }

  @override
  String toString() => "UserRow<userId=$userId, email=$email>";
}
