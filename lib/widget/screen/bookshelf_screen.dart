import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_cubit.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_template.dart';

class BookshelfScreen extends StatelessWidget {
  BookshelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookshelfBooksCubit>(
      create: (context) => BookshelfBooksCubit(),
      child: BookshelfTemplate(),
    );
  }

  static void open(
    BuildContext context, {
    void Function()? callback,
  }) {
    void Function() _callback = (callback != null) ? callback : () {};
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => BookshelfScreen(),
            fullscreenDialog: true,
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
