import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_detail_timeline_cubit.dart';
import 'package:simple_book_log/bloc/bookshelf_item_detail_cubit.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf_item_detail/bookshelf_item_detail_template.dart';

class BookshelfItemDetailScreen extends StatelessWidget {
  final BookRow bookRow;

  const BookshelfItemDetailScreen({
    Key? key,
    required this.bookRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookshelfItemDetailCubit(bookRow: bookRow),
        ),
        BlocProvider(
          create: (context) => BookshelfDetailTimelineCubit(),
        ),
      ],
      child: BookshelfItemDetailTemplate(bookRow: bookRow),
    );

    // <BookshelfItemDetailCubit>(
    //   create: (context) => BookshelfItemDetailCubit(bookRow: bookRow),
    //   child: ,
    // );
  }

  static void open(
    BuildContext context, {
    required BookRow bookRow,
    bool fullscreenDialog = false,
    void Function()? callback,
  }) {
    void Function() _callback = (callback != null) ? callback : () {};
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => BookshelfItemDetailScreen(bookRow: bookRow),
            fullscreenDialog: fullscreenDialog,
          ),
        )
        .then(
          (value) => _callback(),
        );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
