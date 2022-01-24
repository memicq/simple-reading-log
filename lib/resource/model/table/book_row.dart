import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/util/unique_id_generator.dart';

class BookRow {
  final String bookId;
  final String title;
  final String titleKana;
  final String? subTitle;
  final String? subTitleKana;
  final String? seriesName;
  final String? seriesNameKana;
  final String author;
  final String authorKana;
  final String publisherName;
  final String salesDate;
  final String size;
  final String isbn;
  final String itemUrl;
  final int itemPrice;
  final String imageUrl;

  final BookStatus status;
  final String memo;

  BookRow({
    required this.bookId,
    required this.title,
    required this.titleKana,
    required this.subTitle,
    required this.subTitleKana,
    required this.seriesName,
    required this.seriesNameKana,
    required this.author,
    required this.authorKana,
    required this.publisherName,
    required this.salesDate,
    required this.size,
    required this.isbn,
    required this.itemUrl,
    required this.itemPrice,
    required this.imageUrl,
    required this.status,
    required this.memo,
  });

  static BookRow createNewBook({
    required String title,
    required String titleKana,
    required String? subTitle,
    required String? subTitleKana,
    required String? seriesName,
    required String? seriesNameKana,
    required String author,
    required String authorKana,
    required String publisherName,
    required String salesDate,
    required String size,
    required String isbn,
    required String itemUrl,
    required int itemPrice,
    required String imageUrl,
    required BookStatus status,
    required String memo,
  }) {
    String bookId = UniqueIdGenerator().generateId();

    return BookRow(
      bookId: bookId,
      title: title,
      titleKana: titleKana,
      subTitle: subTitle,
      subTitleKana: subTitleKana,
      seriesName: seriesName,
      seriesNameKana: seriesNameKana,
      author: author,
      authorKana: authorKana,
      publisherName: publisherName,
      salesDate: salesDate,
      size: size,
      isbn: isbn,
      itemUrl: itemUrl,
      itemPrice: itemPrice,
      imageUrl: imageUrl,
      status: status,
      memo: memo,
    );
  }

  BookRow.fromSnapshot(QueryDocumentSnapshot snapshot)
      : assert(snapshot.get("title") != null),
        assert(snapshot.get("titleKana") != null),
        assert(snapshot.get("author") != null),
        assert(snapshot.get("authorKana") != null),
        assert(snapshot.get("publisherName") != null),
        assert(snapshot.get("size") != null),
        assert(snapshot.get("isbn") != null),
        assert(snapshot.get("itemUrl") != null),
        assert(snapshot.get("itemPrice") != null),
        assert(snapshot.get("imageUrl") != null),
        assert(snapshot.get("status") != null),
        assert(snapshot.get("memo") != null),
        bookId = snapshot.reference.id,
        title = snapshot.get("title"),
        titleKana = snapshot.get("titleKana"),
        subTitle = snapshot.get("subTitle"),
        subTitleKana = snapshot.get("subTitleKana"),
        seriesName = snapshot.get("seriesName"),
        seriesNameKana = snapshot.get("seriesNameKana"),
        author = snapshot.get("author"),
        authorKana = snapshot.get("authorKana"),
        publisherName = snapshot.get("publisherName"),
        salesDate = snapshot.get("salesDate"),
        size = snapshot.get("size"),
        isbn = snapshot.get("isbn"),
        itemUrl = snapshot.get("itemUrl"),
        itemPrice = snapshot.get("itemPrice"),
        imageUrl = snapshot.get("imageUrl"),
        status = BookStatusExt.fromCode(snapshot.get("status")),
        memo = snapshot.get("memo");

  Map<String, dynamic> toMap() {
    return {
      "bookId": bookId,
      "title": title,
      "titleKana": titleKana,
      "subTitle": subTitle,
      "subTitleKana": subTitleKana,
      "seriesName": seriesName,
      "seriesNameKana": seriesNameKana,
      "author": author,
      "authorKana": authorKana,
      "publisherName": publisherName,
      "salesDate": salesDate,
      "size": size,
      "isbn": isbn,
      "itemUrl": itemUrl,
      "itemPrice": itemPrice,
      "imageUrl": imageUrl,
      "status": status.code,
      "memo": memo,
    };
  }

  BookRow copyWith({
    BookStatus? newStatus,
    String? newMemo,
  }) {
    return BookRow(
      bookId: bookId,
      title: title,
      titleKana: titleKana,
      subTitle: subTitle,
      subTitleKana: subTitleKana,
      seriesName: seriesName,
      seriesNameKana: seriesNameKana,
      author: author,
      authorKana: authorKana,
      publisherName: publisherName,
      salesDate: salesDate,
      size: size,
      isbn: isbn,
      itemUrl: itemUrl,
      itemPrice: itemPrice,
      imageUrl: imageUrl,
      status: newStatus ?? status,
      memo: newMemo ?? memo,
    );
  }

  @override
  String toString() => "BookRow<bookId=$bookId, title=$title>";
}
