import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/table/reading_activity_row.dart';
import 'package:simple_book_log/util/datetime_util.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  final DateTime initialFocusedDate;
  final Map<int, List<ReadingActivityRow>> dayActivities;
  final void Function(DateTime, DateTime)? onDayLongPressed;

  final CalendarFormat initialFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;

  const EventCalendar({
    Key? key,
    required this.initialFocusedDate,
    required this.dayActivities,
    this.onDayLongPressed,
    this.initialFormat = CalendarFormat.twoWeeks,
    this.availableCalendarFormats = const {
      CalendarFormat.month: '月表示',
      CalendarFormat.twoWeeks: '2週表示',
    },
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
    Color eventCellColor = Colors.purple,
    Color eventTextColor = const Color(0xFFFAFAFA),
    Color defaultCellColor = Colors.white,
    Color defaultTextColor = Colors.black,
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
        selectedBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          eventCellColor: Colors.cyan.shade300,
          defaultCellColor: Colors.grey.shade200,
        ),
        defaultBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          eventCellColor: Colors.cyan.shade100,
        ),
        singleMarkerBuilder: null,
        outsideBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          defaultTextColor: const Color(0xFFAEAEAE),
          eventTextColor: const Color(0xFFF2F2F2),
          eventCellColor: Colors.cyan.shade100,
        ),
        todayBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
          eventCellColor: Colors.cyan.shade200,
        ),
        disabledBuilder: (context, day, focusedDay) => _buildDay(
          widget.dayActivities,
          day,
        ),
      ),
    );
  }
}
