import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/common/bookshelf_item_detail_status_tag.dart';

class BookshelfFilterForm extends StatelessWidget {
  Color accentColor;

  BookshelfFilterForm({
    Key? key,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: accentColor,
                ),
                SizedBox(width: 10),
                Text(
                  "フィルター",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.double_arrow_outlined,
                  color: accentColor,
                ),
                SizedBox(width: 10),
                Text(
                  "ステータス",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                BookshelfItemDetailStatusTag(status: BookStatus.reading),
                BookshelfItemDetailStatusTag(status: BookStatus.tsundoku),
                BookshelfItemDetailStatusTag(status: BookStatus.nextToRead),
                BookshelfItemDetailStatusTag(status: BookStatus.finishReading),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
