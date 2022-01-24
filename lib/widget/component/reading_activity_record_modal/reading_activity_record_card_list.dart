import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_display_state_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:simple_book_log/widget/component/common/event_calendar.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_book_item.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_card_header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuple/tuple.dart';

class ReadingActivityRecordCardList extends StatelessWidget {
  final DateTime initialDate;

  const ReadingActivityRecordCardList({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxContentHeight = MediaQuery.of(context).size.height - 325;

    ReadingActivityRecordCubit _readingActivityRecordCubit =
        context.read<ReadingActivityRecordCubit>();

    ReadingActivityRecordDisplayStateCubit _displayStateCubit =
        context.read<ReadingActivityRecordDisplayStateCubit>();

    return BlocBuilder<ReadingActivityRecordCubit, Map<BookRow, bool>>(
      bloc: _readingActivityRecordCubit,
      builder: (context, selectedBooks) {
        print("updateSelectedBooks");

        return BlocBuilder<ReadingActivityRecordDisplayStateCubit, Tuple2<bool, bool>>(
          bloc: _displayStateCubit,
          builder: (context, displayState) {
            bool isDateFormClosed = displayState.item1;
            bool isBooksFormClosed = displayState.item2;

            double dateContentHeight = isDateFormClosed ? 0 : maxContentHeight;
            double bookContentHeight = isBooksFormClosed ? 0 : maxContentHeight;

            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        offset: Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: Material(
                    color: ColorConstants.mainBgColor,
                    child: InkWell(
                      onTap: () => _displayStateCubit.toggleDateFormClosed(),
                      child: ReadingActivityRecordCardHeader(
                        iconData: Icons.calendar_today,
                        title: "読書日:",
                        value: DateTimeUtil.toLocaleDateString(initialDate),
                        isClosed: isDateFormClosed,
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: dateContentHeight,
                    child: EventCalendar(
                      initialFocusedDate: DateTime.now(),
                      dayActivities: {},
                      initialFormat: CalendarFormat.twoWeeks,
                      availableCalendarFormats: const {
                        CalendarFormat.twoWeeks: "2週表示",
                      },
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        offset: Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: Material(
                    color: ColorConstants.mainBgColor,
                    child: InkWell(
                      onTap: () => _displayStateCubit.toggleBooksFormClosed(),
                      child: ReadingActivityRecordCardHeader(
                        iconData: Icons.book_outlined,
                        title: "読んだ本:",
                        value: "未選択",
                        isClosed: isBooksFormClosed,
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: bookContentHeight,
                    child: ListView(
                      children: selectedBooks.entries
                          .map(
                            (entry) => ReadingActivityRecordBookItem(
                              book: entry.key,
                              isChecked: entry.value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderConstant.defaultBorderSide),
                      color: ColorConstants.mainBgColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
