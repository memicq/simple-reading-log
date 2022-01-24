import 'package:flutter/material.dart';
import 'package:simple_book_log/const/fonts.dart';

class BookshelfListItemHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const BookshelfListItemHeader({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontConstants.textStyleBold,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          subTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
