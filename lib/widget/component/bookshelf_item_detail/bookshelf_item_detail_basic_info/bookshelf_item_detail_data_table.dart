import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_basic_info/bookshelf_item_detail_data_row.dart';

class BookshelfItemDetailDataTable extends StatelessWidget {
  final List<BookshelfItemDetailDataRow> rows;
  BookshelfItemDetailDataTable({
    Key? key,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows,
    );
  }
}
