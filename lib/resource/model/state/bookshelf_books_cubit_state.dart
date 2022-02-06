import 'package:simple_book_log/resource/model/table/book_row.dart';

class BookshelfBooksCubitState {
  List<BookRow> allBooks;
  List<BookRow> filteredBooks;

  BookshelfBooksCubitState({
    required this.allBooks,
    required this.filteredBooks,
  });

  static BookshelfBooksCubitState initialState = BookshelfBooksCubitState(
    allBooks: [],
    filteredBooks: [],
  );

  BookshelfBooksCubitState copyWith({
    List<BookRow>? allBooks,
    List<BookRow>? filteredBooks,
  }) {
    return BookshelfBooksCubitState(
      allBooks: allBooks ?? this.allBooks,
      filteredBooks: filteredBooks ?? this.filteredBooks,
    );
  }
}
