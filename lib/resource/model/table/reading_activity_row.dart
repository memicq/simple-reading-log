import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/util/unique_id_generator.dart';

class ReadingActivityRow {
  final String readingActivityId;
  final DateTime activityDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReadingActivityRow({
    required this.readingActivityId,
    required this.activityDate,
    required this.createdAt,
    required this.updatedAt,
  });

  static ReadingActivityRow createNewReadingActivity(
    DateTime activityDate,
  ) {
    String readingActivityId = UniqueIdGenerator().generateId();

    return ReadingActivityRow(
      readingActivityId: readingActivityId,
      activityDate: activityDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  ReadingActivityRow.fromSnapshot(QueryDocumentSnapshot snapshot)
      : assert(snapshot.get("activityDate") != null),
        assert(snapshot.get("createdAt") != null),
        assert(snapshot.get("updatedAt") != null),
        readingActivityId = snapshot.reference.id,
        activityDate = snapshot.get("activityDate").toDate(),
        createdAt = snapshot.get("createdAt").toDate(),
        updatedAt = snapshot.get("updatedAt").toDate();

  Map<String, dynamic> toMap() {
    return {
      "readingActivityId": readingActivityId,
      "activityDate": Timestamp.fromDate(activityDate),
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  @override
  String toString() => "ReadingActivityRow<ReadingActivityId=$readingActivityId>";
}
