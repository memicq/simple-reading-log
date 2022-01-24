import 'package:flutter/material.dart';
import 'package:simple_book_log/util/datetime_util.dart';

class BookshelfItemDetailTimelineItem extends StatelessWidget {
  final DateTime dateTime;
  final String text;

  const BookshelfItemDetailTimelineItem({
    Key? key,
    required this.dateTime,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTimeUtil.toLocaleDateTimeString(dateTime),
              style: const TextStyle(color: Colors.grey),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
