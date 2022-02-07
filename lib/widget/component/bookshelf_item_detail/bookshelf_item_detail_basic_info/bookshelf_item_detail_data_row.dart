import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';

class BookshelfItemDetailDataRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String value;

  const BookshelfItemDetailDataRow({
    Key? key,
    required this.iconData,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            iconData,
            color: _sessionCubit.getAccentColor(),
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title + ":",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(value),
        ],
      ),
    );
  }
}
