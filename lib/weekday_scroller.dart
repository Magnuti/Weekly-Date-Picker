library day_scroller;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekdayScroller extends StatefulWidget {
  WeekdayScroller({
    Key key,
    @required this.selectedDay,
    @required this.changeDay,
    this.weekdayText = 'Week',
    this.weekdays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.unselectedColor = const Color(0xFFFAFAFA),
    this.selectedColor = const Color(0xFF2A2859),
    this.selectedTextColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.weekdayColor = const Color(0xFF303030),
    this.weeknumberColor = const Color(0xFFB2F5FE),
    this.weeknumberTextColor = const Color(0xFF000000),
    this.daysInWeek = 7,
  })  : assert(changeDay != null),
        assert(changeDay != null),
        super(key: key);

  final DateTime selectedDay;
  final Function(DateTime) changeDay;
  final String weekdayText;
  final List<String> weekdays;
  final Color backgroundColor;
  final Color unselectedColor;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color textColor;
  final Color weekdayColor;
  final Color weeknumberColor;
  final Color weeknumberTextColor;
  final int daysInWeek;

  @override
  _WeekdayScrollerState createState() => _WeekdayScrollerState();
}

class _WeekdayScrollerState extends State<WeekdayScroller> {
  final controller = PageController(initialPage: 0);
  final DateTime now = DateTime.now();

  int _weeknumberNow;
  int _weeknumberInSwipe;

  @override
  void initState() {
    super.initState();
    // Weekday calculation from https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    int dayOfYear =
        int.parse(DateFormat('D').format(now)); // day count from. 1. January
    _weeknumberNow = ((dayOfYear - now.weekday + 10) / 7).floor();
    _weeknumberInSwipe = _weeknumberNow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      height: 80,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            color: widget.weeknumberColor,
            child: Text(
              '${widget.weekdayText} $_weeknumberInSwipe',
              style: TextStyle(color: widget.weeknumberTextColor),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (int index) {
                setState(() {
                  _weeknumberInSwipe = _weeknumberNow + index;
                });
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, weekOffset) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekdays(weekOffset),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds a 5 day list of DateButtons
  List<Widget> _weekdays(int weekIndex) {
    List<Widget> weekdays = [];

    for (int i = 0; i < widget.daysInWeek; i++) {
      int offset = i + 1 - now.weekday;
      DateTime dateTime = now.add(Duration(days: weekIndex * 7 + offset));
      weekdays.add(_dateButton(dateTime));
    }
    return weekdays;
  }

  Widget _dateButton(DateTime dateTime) {
    final String weekday = widget.weekdays[dateTime.weekday - 1];
    // No good compare
    final bool isSelected = dateTime.day == widget.selectedDay.day &&
        dateTime.month == widget.selectedDay.month &&
        dateTime.year == widget.selectedDay.year;

    return Expanded(
      // TODO: The GestureDetector doesn't fill the entire parent, only the child, so the onTap may be working so so
      child: GestureDetector(
        onTap: () => widget.changeDay(dateTime),
        child: Column(
          children: <Widget>[
            Text(
              '$weekday',
              style: TextStyle(fontSize: 12.0, color: widget.weekdayColor),
            ),
            CircleAvatar(
              backgroundColor:
                  isSelected ? widget.selectedColor : widget.unselectedColor,
              radius: 16.0,
              child: Text(
                '${dateTime.day}',
                style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected
                        ? widget.selectedTextColor
                        : widget.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
