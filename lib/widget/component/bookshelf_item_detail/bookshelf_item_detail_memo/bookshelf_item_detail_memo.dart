import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_item_detail_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_memo/bookshelf_item_detail_memo_input_modal.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/common/bookshelf_item_detail_card.dart';

class BookshelfItemDetailMemo extends StatelessWidget {
  const BookshelfItemDetailMemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfItemDetailCubit _bookshelfItemDetailCubit = context.read<BookshelfItemDetailCubit>();

    return BlocBuilder<BookshelfItemDetailCubit, BookRow>(
      bloc: _bookshelfItemDetailCubit,
      builder: (context, bookRow) {
        bool isEmpty = (bookRow.memo == "");

        Text contentText = isEmpty
            ? Text(
                "メモが入力されていません",
                style: TextStyle(color: ColorConstants.disabledTextColor),
              )
            : Text(
                bookRow.memo,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              );

        Text buttonText = isEmpty ? const Text("追加する") : const Text("確認・編集する");

        Future<void> updateMemo(String memo) async {
          await _bookshelfItemDetailCubit.updateMemo(_sessionCubit.getCurrentUserId(), memo);
          BookshelfItemDetailMemoInputTemplate.close(context);
        }

        return BookshelfItemDetailCard(
          iconData: Icons.sticky_note_2_outlined,
          title: "メモ",
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
            constraints: const BoxConstraints(minHeight: 50, maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: contentText,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(_sessionCubit.getAccentColor()),
                    ),
                    onPressed: () => BookshelfItemDetailMemoInputTemplate.open(
                        context, bookRow.memo, updateMemo),
                    child: buttonText,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
