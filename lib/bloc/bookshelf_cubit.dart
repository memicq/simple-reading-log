import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/resource/repository/book_repository.dart';
import 'package:simple_book_log/util/kana_util.dart';

class BookshelfBooksCubit extends Cubit<List<BookRow>> {
  BookshelfBooksCubit() : super(List.empty());

  final BookRepository _bookRepository = BookRepository();

  List<BookRow> _bookRows = List.empty();
  List<BookRow> _filteredBookRows = List.empty();

  Future<void> list(String userId) async {
    _bookRows = await _bookRepository.list(userId);
    _filteredBookRows = _bookRows;
    emit(_filteredBookRows);
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

    _filteredBookRows = _bookRows.where((bookRow) => _isMatch(bookRow, query)).toList();
    emit(_filteredBookRows);
  }
}
