import 'package:simple_book_log/resource/model/table/book_row.dart';

class ReadingActivityRecordCubitState {
  DateTime selectedDate;
  Map<BookRow, bool> selectedBooks;

  ReadingActivityRecordCubitState({
    required this.selectedDate,
    required this.selectedBooks,
  });

  static ReadingActivityRecordCubitState initialState =
      ReadingActivityRecordCubitState(selectedDate: DateTime.now(), selectedBooks: {});

  ReadingActivityRecordCubitState copyWith({
    DateTime? selectedDate,
    Map<BookRow, bool>? selectedBooks,
  }) {
    return ReadingActivityRecordCubitState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedBooks: selectedBooks ?? this.selectedBooks,
    );
  }
}
