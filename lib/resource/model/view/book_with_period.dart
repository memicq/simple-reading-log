import 'package:simple_book_log/resource/model/table/book_row.dart';

class BookWithPeriod {
  final BookRow bookRow;
  final DateTime? startDate;
  final DateTime endDate;

  BookWithPeriod({
    required this.bookRow,
    required this.startDate,
    required this.endDate,
  });
}
