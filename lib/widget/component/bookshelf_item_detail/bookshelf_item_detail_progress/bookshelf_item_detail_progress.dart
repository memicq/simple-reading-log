import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_progress/bookshelf_item_detail_status.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/common/bookshelf_item_detail_card.dart';

class BookshelfItemDetailProgress extends StatelessWidget {
  final BookRow bookRow;

  const BookshelfItemDetailProgress({
    Key? key,
    required this.bookRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BookshelfItemDetailCard(
      iconData: Icons.double_arrow_outlined,
      title: "進捗",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BookshelfItemDetailStatus(
              bookStatus: bookRow.status,
            ),
          ],
        ),
      ),
    );
  }
}
