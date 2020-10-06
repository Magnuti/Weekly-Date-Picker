library day_scroller;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekdayScroller extends StatefulWidget {
  WeekdayScroller({
    Key key,
    @required this.selectedDay,
    @required this.selectDay,
    this.weekdayText = 'Week',
    this.weekdays = const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.selectedColor = const Color(0xFF0277BD),
    this.selectedTextColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.weeknumberColor = const Color(0xFF0277BD),
  })  : assert(selectDay != null),
        assert(selectDay != null),
        super(key: key);

  final DateTime selectedDay;
  final Function(DateTime) selectDay;
  final String weekdayText;
  final List<String> weekdays;
  final Color backgroundColor;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color textColor;
  final Color weeknumberColor;

  @override
  _WeekdayScrollerState createState() => _WeekdayScrollerState();
}

class _WeekdayScrollerState extends State<WeekdayScroller> {
  final controller = PageController(initialPage: 0);
  final DateTime now = DateTime.now();

  int _weeknumberNow;
  int _weeknumberInSwipe;

  _WeekdayScrollerState() {
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
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            color: widget.weeknumberColor,
            child: Text('${widget.weekdayText} $_weeknumberInSwipe'),
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
    int _weekdayOffset() {
      // 0 = Monday, 1 = Tuesday...
      return now.weekday - 1;
    }

    List<Widget> weekdays = [];
    for (int i = _weekdayOffset() * (-1); i < 5 - _weekdayOffset(); i++) {
      DateTime date = now.add(Duration(days: weekIndex * 7 + i));
      weekdays.add(
        _dateButton(
            date,
            // TODO No good compare
            date.day == widget.selectedDay.day &&
                date.month == widget.selectedDay.month &&
                date.year == widget.selectedDay.year),
      );
    }
    return weekdays;
  }

  Widget _dateButton(DateTime dateTime, bool isSelected) {
    String weekday = widget.weekdays[dateTime.weekday];

    return Expanded(
      // TODO: The GestureDetector doesn't fill the entire parent, only the child, so the onTap may be working so so
      child: GestureDetector(
          onTap: () => widget.selectDay(dateTime),
          child: Column(
            children: <Widget>[
              Text(
                '$weekday',
                style: TextStyle(
                    fontSize: 12.0,
                    color: isSelected
                        ? widget.selectedColor
                        : widget.backgroundColor),
              ),
              CircleAvatar(
                  backgroundColor: isSelected
                      ? widget.selectedColor
                      : widget.backgroundColor,
                  radius: 16.0,
                  child: Text(
                    '${dateTime.day}',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: isSelected
                            ? widget.selectedTextColor
                            : widget.textColor),
                  ))
            ],
          )),
    );
  }
}
