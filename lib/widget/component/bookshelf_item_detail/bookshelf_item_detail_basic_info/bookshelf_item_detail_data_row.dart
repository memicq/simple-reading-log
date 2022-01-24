import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';

class BookshelfItemDetailDataRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String value;

  const BookshelfItemDetailDataRow({
    Key? key,
    required this.iconData,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            iconData,
            color: ColorConstants.accentColor,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title + ":",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(value),
        ],
      ),
    );
  }
}
