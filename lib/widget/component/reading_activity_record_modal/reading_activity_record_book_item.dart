import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';

class ReadingActivityRecordBookItem extends StatelessWidget {
  BookRow book;
  bool isChecked;
  bool toggleDisabled;

  ReadingActivityRecordBookItem({
    Key? key,
    required this.book,
    required this.isChecked,
    this.toggleDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadingActivityRecordCubit _readingActivityRecordCubit =
        context.read<ReadingActivityRecordCubit>();

    Color bgColor = isChecked ? Colors.grey.shade50 : Colors.white;

    return Material(
      color: bgColor,
      child: InkWell(
        onTap: () {
          if (!toggleDisabled) {
            _readingActivityRecordCubit.toggleBookSelection(book.bookId);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderConstant.defaultBorderSide,
              bottom: BorderConstant.defaultBorderSide,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {},
              ),
              Container(
                height: 70,
                width: 70,
                color: Colors.black12,
                child: CachedNetworkImage(
                  imageUrl: book.imageUrl,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book.author,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
