import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/bookshelf_addition_cubit.dart';
import 'package:simple_book_log/bloc/rakuten_book_api_search_state_cubit.dart';
import 'package:simple_book_log/widget/component/bookshelf_addition/bookshelf_addition_template.dart';

class BookshelfAdditionScreen extends StatelessWidget {
  const BookshelfAdditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RakutenBookApiSearchStateCubit>(
          create: (context) => RakutenBookApiSearchStateCubit(),
        ),
        BlocProvider<BookshelfAdditionCubit>(
          create: (context) => BookshelfAdditionCubit(),
        ),
      ],
      child: const BookshelfAdditionTemplate(),
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
            builder: (context) => const BookshelfAdditionScreen(),
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
