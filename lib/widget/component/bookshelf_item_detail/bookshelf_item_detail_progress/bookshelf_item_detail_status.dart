import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_item_detail_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/common/bookshelf_item_detail_status_tag.dart';

class BookshelfItemDetailStatus extends StatelessWidget {
  BookStatus bookStatus;

  BookshelfItemDetailStatus({
    Key? key,
    required this.bookStatus,
  }) : super(key: key);

  void _showModalPicker(
    BuildContext context,
    String userId,
    BookshelfItemDetailCubit _cubit,
  ) {
    List<BookStatus> statuses = BookStatus.values;
    BookStatus _selectedBookStatus = BookStatus.tsundoku;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: GestureDetector(
            onTap: () async {
              if (bookStatus != _selectedBookStatus) {
                await _cubit.updateStatus(userId, _selectedBookStatus);
              }
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 35,
              children: statuses.map((status) => Text(status.japaneseName!)).toList(),
              onSelectedItemChanged: (index) => _selectedBookStatus = statuses[index],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfItemDetailCubit _bookshelfItemDetailCubit = context.read<BookshelfItemDetailCubit>();
    String userId = _sessionCubit.getCurrentUserId();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BookshelfItemDetailStatusTag(status: bookStatus),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(ColorConstants.accentColor),
          ),
          onPressed: () => _showModalPicker(context, userId, _bookshelfItemDetailCubit),
          child: const Text("更新する"),
        )
      ],
    );
  }
}
