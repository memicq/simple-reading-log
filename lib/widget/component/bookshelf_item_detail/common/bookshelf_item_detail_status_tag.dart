import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';

class BookshelfItemDetailStatusTag extends StatelessWidget {
  final BookStatus status;
  const BookshelfItemDetailStatusTag({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        color: status.color!,
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: status.color!),
      ),
      child: Center(
        child: Text(
          status.japaneseName!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
