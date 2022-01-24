import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_basic_info/bookshelf_item_detail_data_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_basic_info/bookshelf_item_detail_data_table.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_basic_info/bookshelf_item_detail_header.dart';
import 'package:simple_book_log/widget/component/common/rectangle_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BookshelfItemDetailBasicInfo extends StatelessWidget {
  final BookRow bookRow;

  const BookshelfItemDetailBasicInfo({
    Key? key,
    required this.bookRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderConstant.defaultBorderSide,
          bottom: BorderConstant.defaultBorderSide,
        ),
      ),
      child: Column(
        children: [
          RectangleImage(
            imageUrl: bookRow.imageUrl,
            height: 200,
            width: double.infinity,
          ),
          BookshelfItemDetailHeader(
            title: bookRow.title,
            author: bookRow.author,
          ),
          BookshelfItemDetailDataTable(
            rows: [
              BookshelfItemDetailDataRow(
                iconData: Icons.corporate_fare_outlined,
                title: "出版社",
                value: bookRow.publisherName,
              ),
              BookshelfItemDetailDataRow(
                iconData: Icons.calendar_today_outlined,
                title: "出版日",
                value: bookRow.salesDate,
              ),
              BookshelfItemDetailDataRow(
                iconData: Icons.qr_code,
                title: "ISBNコード",
                value: bookRow.isbn,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text("詳細を見る"),
              onPressed: () => launch(bookRow.itemUrl),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(ColorConstants.accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
