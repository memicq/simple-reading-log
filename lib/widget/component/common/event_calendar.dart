import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  final DateTime initialFocusedDate;
  final DateTime? initialSelectedDate;
  final Map<int, List<ReadingActivityRow>> dayActivities;
  final void Function(DateTime, DateTime)? onDayLongPressed;

  final CalendarFormat initialFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;

  // デフォルト
  final Color defaultCellColor;
  final Color defaultTextColor;
  final Color defaultEventCellColor;
  final Color defaultEventTextColor;

  // 月外
  final Color outsideCellColor;
  final Color outsideTextColor;
  final Color outsideEventCellColor;
  final Color outsideEventTextColor;

  // 今日
  final Color todayCellColor;
  final Color todayTextColor;
  final Color todayEventCellColor;
  final Color todayEventTextColor;

  // 選択中
  final Color selectedCellColor;
  final Color selectedTextColor;
  final Color selectedEventCellColor;
  final Color selectedEventTextColor;

  EventCalendar({
    Key? key,
    required this.initialFocusedDate,
    this.initialSelectedDate,
    required this.dayActivities,
    this.onDayLongPressed,
    this.initialFormat = CalendarFormat.twoWeeks,
    this.availableCalendarFormats = const {
      CalendarFormat.month: '月表示',
      CalendarFormat.twoWeeks: '2週表示',
    },
    this.defaultCellColor = Colors.white,
    this.defaultTextColor = Colors.black,
    this.defaultEventCellColor = Colors.purple,
    this.defaultEventTextColor = const Color(0xFFFAFAFA),
    this.outsideCellColor = Colors.white,
    this.outsideTextColor = Colors.black,
    this.outsideEventCellColor = Colors.purple,
    this.outsideEventTextColor = const Color(0xFFFAFAFA),
    this.todayCellColor = Colors.white,
    this.todayTextColor = Colors.black,
    this.todayEventCellColor = Colors.purple,
    this.todayEventTextColor = const Color(0xFFFAFAFA),
    this.selectedCellColor = Colors.white,
    this.selectedTextColor = Colors.black,
    this.selectedEventCellColor = Colors.purple,
    this.selectedEventTextColor = const Color(0xFFFAFAFA),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EventCalendarState();
}

class EventCalendarState extends State<EventCalendar> {
  static const double _rowHeight = 52.0;
  static const double _rowPadding = 6.0;

  CalendarFormat? _format;

  DateTime? _selectedDate;
  DateTime? _focusedDate;

  @override
  void initState() {
    _format = widget.initialFormat;
    _selectedDate = widget.initialSelectedDate;
    _focusedDate = widget.initialFocusedDate;
    super.initState();
  }

  void _changeCalendarFormat(CalendarFormat format) {
    if (_format != format) {
      setState(() {
        _format = format;
      });
    }
  }

  void _selectDate(DateTime selectedDate, DateTime focusedDate) {
    if (!isSameDay(selectedDate, _selectedDate)) {
      setState(() {
        _selectedDate = selectedDate;
        focusedDate = focusedDate;
      });
    }
  }

  AnimatedContainer _buildDayContainer({
    required String innerText,
    EdgeInsetsGeometry margin = const EdgeInsets.all(6.0),
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Color cellBgColor = Colors.transparent,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    TextStyle textStyle = const TextStyle(),
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(color: cellBgColor, borderRadius: borderRadius),
      alignment: Alignment.center,
      child: Text(
        innerText,
        style: textStyle,
      ),
    );
  }

  Widget _buildDay(
    Map<int, List<ReadingActivityRow>> dayActivities,
    DateTime day, {
    required Color eventCellColor,
    required Color eventTextColor,
    required Color defaultCellColor,
    required Color defaultTextColor,
  }) {
    DateTime yesterday = day.subtract(const Duration(days: 1));
    DateTime tomorrow = day.add(const Duration(days: 1));

    bool existEventDayBefore = dayActivities.containsKey(DateTimeUtil.dateKey(yesterday));
    bool existEventDay = dayActivities.containsKey(DateTimeUtil.dateKey(day));
    bool existEventDayAfter = dayActivities.containsKey(DateTimeUtil.dateKey(tomorrow));

    if (existEventDay) {
      if (existEventDayBefore && existEventDayAfter) {
        return _buildDayContainer(
          innerText: day.day.toString(),
          margin: const EdgeInsets.symmetric(vertical: _rowPadding),
          cellBgColor: eventCellColor,
          borderRadius: BorderRadius.zero,
          textStyle: TextStyle(color: eventTextColor, fontSize: 16.0),
        );
      }

      if (existEventDayBefore) {
        return _buildDayContainer(
          innerText: day.day.toString(),
          margin: const EdgeInsets.only(top: _rowPadding, bottom: _rowPadding, right: _rowPadding),
          padding: const EdgeInsets.only(left: _rowPadding),
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
          cellBgColor: eventCellColor,
          textStyle: TextStyle(color: eventTextColor, fontSize: 16.0),
        );
      }

      if (existEventDayAfter) {
        return _buildDayContainer(
          innerText: day.day.toString(),
          margin: const EdgeInsets.only(top: _rowPadding, bottom: _rowPadding, left: _rowPadding),
          padding: const EdgeInsets.only(right: _rowPadding),
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
          cellBgColor: eventCellColor,
          textStyle: TextStyle(color: eventTextColor, fontSize: 16.0),
        );
      }

      return _buildDayContainer(
        innerText: day.day.toString(),
        margin: const EdgeInsets.all(_rowPadding),
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        cellBgColor: eventCellColor,
        textStyle: TextStyle(color: eventTextColor, fontSize: 16.0),
      );
    }

    return _buildDayContainer(
      innerText: day.day.toString(),
      cellBgColor: defaultCellColor,
      textStyle: TextStyle(color: defaultTextColor, fontSize: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "ja_JP",
      focusedDay: _focusedDate!,
      firstDay: DateTime(1990),
      lastDay: DateTime(2040),
      calendarFormat: _format!,
      availableCalendarFormats: widget.availableCalendarFormats,
      rowHeight: _rowHeight,
      onFormatChanged: (format) => _changeCalendarFormat(format),
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekHeight: 20,
      onDayLongPressed: (selectedDate, focusedDate) {
        _selectDate(selectedDate, focusedDate);
        if (widget.onDayLongPressed != null) {
          widget.onDayLongPressed!(selectedDate, focusedDate);
        }
      },
      selectedDayPredicate: (date) => isSameDay(_selectedDate, date),
      onDaySelected: (selectedDate, focusedDate) => _selectDate(selectedDate, focusedDate),
      onPageChanged: (focusedDate) => focusedDate = focusedDate,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: widget.defaultTextColor,
          defaultCellColor: widget.defaultCellColor,
          eventTextColor: widget.defaultEventTextColor,
          eventCellColor: widget.defaultEventCellColor,
        ),
        selectedBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: widget.selectedTextColor,
          defaultCellColor: widget.selectedCellColor,
          eventTextColor: widget.selectedEventTextColor,
          eventCellColor: widget.selectedEventCellColor,
        ),
        singleMarkerBuilder: null,
        outsideBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: widget.outsideTextColor,
          defaultCellColor: widget.outsideCellColor,
          eventTextColor: widget.outsideEventTextColor,
          eventCellColor: widget.outsideEventCellColor,
        ),
        todayBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: widget.todayTextColor,
          defaultCellColor: widget.todayCellColor,
          eventTextColor: widget.todayEventTextColor,
          eventCellColor: widget.todayEventCellColor,
          // eventCellColor: Colors.cyan.shade200,
        ),
        disabledBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: widget.defaultTextColor,
          defaultCellColor: widget.defaultCellColor,
          eventTextColor: widget.defaultEventTextColor,
          eventCellColor: widget.defaultEventCellColor,
        ),
      ),
    );
  }
}
