import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';

class BookshelfListItemStatusTag extends StatelessWidget {
  final BookStatus status;

  BookshelfListItemStatusTag({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          status.japaneseName!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
