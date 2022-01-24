import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/bookshelf_addition/book_selection/book_selection_input_area.dart';
import 'package:simple_book_log/widget/component/bookshelf_addition/book_selection/book_selection_list.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';

class BookshelfAdditionTemplate extends StatelessWidget {
  const BookshelfAdditionTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      title: "本を追加",
      body: Column(
        children: [
          BookSelectionInputArea(),
          const Expanded(
            child: BookSelectionList(),
          ),
        ],
      ),
    );
  }
}
