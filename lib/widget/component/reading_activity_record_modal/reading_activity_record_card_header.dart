import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';

class ReadingActivityRecordCardHeader extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String value;
  final bool isClosed;

  const ReadingActivityRecordCardHeader({
    Key? key,
    required this.iconData,
    required this.title,
    required this.value,
    required this.isClosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    IconData _toggleIcon = isClosed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: _sessionCubit.getAccentColor(),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(value),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Icon(_toggleIcon),
            ),
          ),
        ],
      ),
    );
  }
}
