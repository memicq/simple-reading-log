import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_item_detail_cubit.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_basic_info/bookshelf_item_detail_basic_info.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_deletion/bookshelf_item_detail_deletion.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_memo/bookshelf_item_detail_memo.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_progress/bookshelf_item_detail_progress.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_timeline/bookshelf_item_detail_timeline.dart';
import 'package:simple_book_log/widget/component/common/column_spacer.dart';
import 'package:simple_book_log/widget/component/common/rounded_primary_button.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_modal.dart';

class BookshelfItemDetailTemplate extends StatelessWidget {
  final BookRow bookRow;

  const BookshelfItemDetailTemplate({
    Key? key,
    required this.bookRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookshelfItemDetailCubit _bookshelfItemDetailCubit = context.read<BookshelfItemDetailCubit>();

    return TemplateScaffold(
      title: "詳細",
      body: BlocBuilder<BookshelfItemDetailCubit, BookRow>(
        bloc: _bookshelfItemDetailCubit,
        builder: (context, bookRow) {
          return Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  BookshelfItemDetailBasicInfo(bookRow: bookRow),
                  const ColumnSpacer(),
                  BookshelfItemDetailProgress(
                    bookRow: bookRow,
                  ),
                  const ColumnSpacer(),
                  const BookshelfItemDetailMemo(),
                  const ColumnSpacer(),
                  BookshelfItemDetailTimeline(
                    bookId: bookRow.bookId,
                  ),
                  const ColumnSpacer(),
                  BookshelfItemDetailDeletion(
                    bookId: bookRow.bookId,
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
              Positioned(
                bottom: 40,
                right: 20,
                child: RoundedPrimaryButton(
                  iconData: Icons.post_add_outlined,
                  onPressed: () => ReadingActivityRecordModal.open(context),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
