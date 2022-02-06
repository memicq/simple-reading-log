import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/state/bookshelf_books_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/util/kana_util.dart';

class BookshelfBooksCubit extends Cubit<BookshelfBooksCubitState> {
  BookshelfBooksCubit() : super(BookshelfBooksCubitState.initialState);

  final BookRepository _bookRepository = BookRepository();

  BookshelfBooksCubitState _state = BookshelfBooksCubitState.initialState;

  Future<void> initialize(String userId) async {
    List<BookRow> allBooks = await _bookRepository.list(userId);
    _state = _state.copyWith(allBooks: allBooks, filteredBooks: allBooks);
    emit(_state);
  }

  Future<void> listBy(String query) async {
    bool _isMatch(BookRow book, String query) {
      return book.title.contains(query) ||
          book.titleKana.contains(query) ||
          KanaUtil.kanaToHira(book.titleKana).contains(query) ||
          book.author.contains(query) ||
          book.authorKana.contains(query) ||
          KanaUtil.kanaToHira(book.authorKana).contains(query) ||
          book.isbn == query;
    }

    List<BookRow> _filteredBookRows = _state.allBooks
        .where(
          (bookRow) => _isMatch(bookRow, query),
        )
        .toList();
    _state = _state.copyWith(filteredBooks: _filteredBookRows);
    emit(_state);
  }
}
