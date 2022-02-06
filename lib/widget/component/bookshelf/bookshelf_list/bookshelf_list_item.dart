import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/bookshelf_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_list/bookshelf_list_item_header.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_list/bookshelf_list_item_tag.dart';
import 'package:simple_book_log/widget/component/common/rectangle_image.dart';
import 'package:simple_book_log/widget/screen/bookshelf_item_detail_screen.dart';

class BookshelfListItem extends StatelessWidget {
  final BookRow bookRow;

  const BookshelfListItem({
    Key? key,
    required this.bookRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfBooksCubit _bookshelfBooksCubit = context.read<BookshelfBooksCubit>();

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => BookshelfItemDetailScreen.open(
          context,
          bookRow: bookRow,
          callback: () => _bookshelfBooksCubit.initialize(_sessionCubit.getCurrentUserId()),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderConstant.defaultBorderSide,
              bottom: BorderConstant.defaultBorderSide,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              RectangleImage(imageUrl: bookRow.imageUrl, height: 80, width: 80),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: BookshelfListItemHeader(
                        title: bookRow.title,
                        subTitle: bookRow.author,
                      ),
                    ),
                    BookshelfListItemStatusTag(status: bookRow.status),
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
