import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/rakuten_book_api_search_state_cubit.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_result.dart';
import 'package:simple_book_log/widget/component/bookshelf_addition/book_selection/book_selection_list_item.dart';
import 'package:simple_book_log/widget/component/bookshelf_addition/book_selection/book_selection_no_result.dart';

class BookSelectionList extends StatelessWidget {
  const BookSelectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RakutenBookApiSearchStateCubit _rakutenCubit = context.read<RakutenBookApiSearchStateCubit>();
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 50),
          width: double.infinity,
          child: BlocBuilder<RakutenBookApiSearchStateCubit, RakutenBookApiSearchResult?>(
            bloc: _rakutenCubit,
            builder: (context, result) {
              if (result == null) return BookSelectionNoResult();

              List<RakutenBookApiSearchResultItem> items = result.items;
              List<Widget> listItems =
                  items.map((item) => BookSelectionListItem(rakutenBook: item)).toList();
              return Column(children: listItems);
            },
          ),
        ),
      ),
    );
  }
}
