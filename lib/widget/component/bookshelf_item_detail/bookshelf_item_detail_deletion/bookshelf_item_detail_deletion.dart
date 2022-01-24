import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/bookshelf_item_detail_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/widget/screen/bookshelf_item_detail_screen.dart';

class BookshelfItemDetailDeletion extends StatelessWidget {
  final String bookId;

  BookshelfItemDetailDeletion({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfItemDetailCubit _bookshelfItemDetailCubit = context.read<BookshelfItemDetailCubit>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerRight,
      // decoration: BoxDecoration(
      //   color: ColorConstants.mainBgColor,
      //   border: Border(
      //     top: BorderConstant.defaultBorderSide,
      //     bottom: BorderConstant.defaultBorderSide,
      //   ),
      // ),
      child: TextButton(
        onPressed: () {},
        onLongPress: () async {
          await _bookshelfItemDetailCubit.deleteBook(_sessionCubit.getCurrentUserId(), bookId);
          BookshelfItemDetailScreen.close(context);
        },
        child: const Text(
          "この本を削除する",
          style: TextStyle(color: Colors.grey),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
      ),
    );
  }
}
