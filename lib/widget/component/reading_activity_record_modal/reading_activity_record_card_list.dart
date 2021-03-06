import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_cubit.dart';
import 'package:simple_book_log/bloc/reading_activity_record_display_state_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/state/reading_activity_record_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:simple_book_log/widget/component/common/event_calendar.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_book_item.dart';
import 'package:simple_book_log/widget/component/reading_activity_record_modal/reading_activity_record_card_header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuple/tuple.dart';

class ReadingActivityRecordCardList extends StatelessWidget {
  final DateTime initialDate;
  final BookRow? onlyBook;

  const ReadingActivityRecordCardList({
    Key? key,
    required this.initialDate,
    this.onlyBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxContentHeight = MediaQuery.of(context).size.height - 325;

    SessionCubit _sessionCubit = context.read<SessionCubit>();
    ReadingActivityRecordCubit _readingActivityRecordCubit =
        context.read<ReadingActivityRecordCubit>();
    ReadingActivityRecordDisplayStateCubit _displayStateCubit =
        context.read<ReadingActivityRecordDisplayStateCubit>();

    Color _calendarColor = _sessionCubit.getAccentColor();

    return BlocBuilder<ReadingActivityRecordCubit, ReadingActivityRecordCubitState>(
      bloc: _readingActivityRecordCubit,
      builder: (context, state) {
        int selectCount = state.selectedBooks.values.where((bool selected) => selected).length;

        return BlocBuilder<ReadingActivityRecordDisplayStateCubit, Tuple2<bool, bool>>(
          bloc: _displayStateCubit,
          builder: (context, displayState) {
            bool isDateFormClosed = displayState.item1;
            bool isBooksFormClosed = displayState.item2;

            double dateContentHeight = isDateFormClosed ? 0 : maxContentHeight;
            double bookContentHeight = isBooksFormClosed ? 0 : maxContentHeight;

            Widget _bookListView = state.selectedBooks.entries.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 60,
                          color: ColorConstants.grayTextColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "????????????????????????????????????????????????",
                          style: TextStyle(color: ColorConstants.grayTextColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "????????????????????????????????????????????????",
                          style: TextStyle(color: ColorConstants.grayTextColor),
                        ),
                        Text(
                          "?????????????????????????????????????????????????????????",
                          style: TextStyle(color: ColorConstants.grayTextColor),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: state.selectedBooks.entries
                        .map(
                          (entry) => ReadingActivityRecordBookItem(
                            book: entry.key,
                            isChecked: entry.value,
                            toggleDisabled: onlyBook != null,
                          ),
                        )
                        .toList(),
                  );

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
                        title: "?????????:",
                        value: DateTimeUtil.toLocaleDateString(initialDate),
                        isClosed: isDateFormClosed,
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: dateContentHeight,
                    child: EventCalendar(
                      initialFocusedDate: DateTime.now(),
                      initialSelectedDate: initialDate,
                      dayActivities: {},
                      initialFormat: CalendarFormat.month,
                      availableCalendarFormats: const {
                        CalendarFormat.month: "?????????",
                      },
                      defaultEventCellColor: _calendarColor.withAlpha(100),
                      selectedEventCellColor: _calendarColor.withAlpha(200),
                      selectedCellColor: Colors.grey.shade200,
                      outsideTextColor: const Color(0xFFAEAEAE),
                      outsideEventCellColor: _calendarColor.withAlpha(50),
                      outsideEventTextColor: const Color(0xFFF2F2F2),
                      todayEventCellColor: _calendarColor.withAlpha(150),
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
                        title: "????????????:",
                        value: (selectCount == 0) ? "?????????" : "$selectCount????????????",
                        isClosed: isBooksFormClosed,
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: bookContentHeight,
                    child: _bookListView,
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
