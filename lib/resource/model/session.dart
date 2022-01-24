import 'package:simple_book_log/resource/model/table/user_row.dart';

class Session {
  final UserRow? user;

  Session({
    this.user,
  });

  @override
  String toString() => 'Session<user=$user>';
}
