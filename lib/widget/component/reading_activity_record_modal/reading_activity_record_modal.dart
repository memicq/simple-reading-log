import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_display_state_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/common/is_bottom_space.dart';
import 'package:simple_book_log/widget/component/common/modal_bottom_sheet.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_card_list.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_modal_bottom.dart';

class ReadingActivityRecordModal extends StatelessWidget {
  DateTime selectedDate;
  List<BookRow> selectedBooks = [];

  ReadingActivityRecordModal({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  static open(
    BuildContext context, {
    DateTime? initialDate,
    void Function(DateTime, List<BookRow>)? onSelected,
    List<BookRow> books = const [],
  }) {
    DateTime _date = (initialDate != null) ? initialDate : DateTime.now();
    void Function(DateTime, List<BookRow>) _onSelected =
        (onSelected != null) ? onSelected : (date, books) {};

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ReadingActivityRecordModal(selectedDate: _date);
      },
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
  }

  void onBooksSelected(List<BookRow> books) {
    selectedBooks = books;
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReadingActivityRecordCubit>(
          create: (context) =>
              ReadingActivityRecordCubit()..listByStatus(_sessionCubit.getCurrentUserId()),
        ),
        BlocProvider(
          create: (context) => ReadingActivityRecordDisplayStateCubit(),
        )
      ],
      child: ModalBottomSheet(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderConstant.defaultBorderSide,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: ColorConstants.accentColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "読書記録を追加",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReadingActivityRecordCardList(
                  initialDate: selectedDate,
                ),
              ),
              ReadingActivityRecordModalBottom(),
              const IosBottomSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
