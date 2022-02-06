import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/rakuten_book_api_search_state_cubit.dart';

class BookSelectionInputArea extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  BookSelectionInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RakutenBookApiSearchStateCubit _rakutenCubit = context.read<RakutenBookApiSearchStateCubit>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black26),
        ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.search),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          hintText: "タイトルや著者名、ISBNコードで検索",
          hintStyle: TextStyle(color: Colors.black26),
          border: InputBorder.none,
        ),
        onEditingComplete: () async {
          await _rakutenCubit.searchByQuery(_controller.value.text);
          _focusNode.unfocus();
        },
      ),
    );
  }
}
