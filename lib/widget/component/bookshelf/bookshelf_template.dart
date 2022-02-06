import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/resource/model/state/bookshelf_books_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_books_not_found.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_list/bookshelf_list_divider.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_list/bookshelf_list_item.dart';
import 'package:simple_book_log/widget/component/common/rounded_primary_button.dart';
import 'package:simple_book_log/widget/component/common/template_sliver_scaffold.dart';
import 'package:simple_book_log/widget/screen/bookshelf_addition_screen.dart';

class BookshelfTemplate extends StatelessWidget {
  BookshelfTemplate({
    Key? key,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  List<Widget> buildBookList(List<BookRow> bookRows) {
    List<BookshelfListItem> items = bookRows
        .map(
          (bookRow) => BookshelfListItem(bookRow: bookRow),
        )
        .toList();

    List<String> initials =
        items.map((ele) => ele.bookRow.titleKana.substring(0, 1)).toSet().toList()..sort();

    List<Widget> headerAndItems = initials
        .map(
          (ini) => [
            BookshelfListDivider(title: ini),
            ...items.where((item) => item.bookRow.titleKana.startsWith(ini)).toList()
          ],
        )
        .expand((e) => e)
        .toList();

    return headerAndItems;
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfBooksCubit _booksCubit = context.read<BookshelfBooksCubit>();
    String _userId = _sessionCubit.getCurrentUserId();

    return TemplateSliverScaffold(
      title: "本棚",
      header: Container(
        height: 40,
        alignment: Alignment.topCenter,
        child: TextField(
          controller: _controller,
          style: const TextStyle(
            fontSize: 13,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "検索",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderConstant.defaultBorderSide,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
          onEditingComplete: () => _booksCubit.listBy(_controller.value.text),
        ),
      ),
      children: [
        BlocBuilder<BookshelfBooksCubit, BookshelfBooksCubitState>(
          bloc: _booksCubit,
          builder: (context, _state) {
            if (_state.allBooks.isEmpty) {
              return BookshelfBooksNotFound();
            }
            return Column(
              children: buildBookList(_state.filteredBooks),
            );
          },
        ),
      ],
      floatingActionButton: RoundedPrimaryButton(
        onPressed: () => BookshelfAdditionScreen.open(
          context,
          callback: () => _booksCubit.initialize(_userId),
        ),
        iconData: Icons.add,
      ),
    );
  }
}
