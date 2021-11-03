import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

void main() {
  final DateTime defaultTime = DateTime(2021, 09, 28, 14, 0);
  final List<int> defaultDates = [27, 28, 29, 30, 1, 2, 3];
  final List<String> defaultWeekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  testWidgets("WeeklyDatePicker works with MaterialApp",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
                selectedDay: clock.now(), changeDay: (value) => {})),
      );
      final weekTextFinder = find.text("Week 39");
      expect(weekTextFinder, findsOneWidget);

      for (String weekday in defaultWeekdays) {
        final weekdayFinder = find.text(weekday);
        expect(weekdayFinder, findsOneWidget);
      }

      for (int date in defaultDates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }
    });
  });

  testWidgets("WeeklyDatePicker works with CupertinoApp",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        CupertinoApp(
            home: WeeklyDatePicker(
                selectedDay: clock.now(), changeDay: (value) => {})),
      );

      final weekTextFinder = find.text("Week 39");
      expect(weekTextFinder, findsOneWidget);

      for (String weekday in defaultWeekdays) {
        final weekdayFinder = find.text(weekday);
        expect(weekdayFinder, findsOneWidget);
      }

      for (int date in defaultDates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }
    });
  });

  testWidgets(
      "WeeklyDatePicker shows all custom weekdays with custom week length",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      final List<String> weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr'];
      final List<int> dates = [27, 28, 29, 30, 1];

      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
          selectedDay: clock.now(),
          changeDay: (value) => {},
          weekdays: weekdays,
          daysInWeek: 5,
        )),
      );

      for (String weekday in weekdays) {
        final weekdayFinder = find.text(weekday);
        expect(weekdayFinder, findsOneWidget);
      }

      for (int date in dates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }
    });
  });

  testWidgets("WeeklyDatePicker correctly does not display the week text",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
          selectedDay: clock.now(),
          changeDay: (value) => {},
          enableWeeknumberText: false,
        )),
      );

      final weekTextFinder = find.text("Week 39");
      expect(weekTextFinder, findsNothing);
    });
  });

  testWidgets("WeeklyDatePicker allows custom week text",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
          selectedDay: clock.now(),
          changeDay: (value) => {},
          weekdayText: "Uke",
        )),
      );

      final weekTextFinder = find.text("Week 39");
      expect(weekTextFinder, findsNothing);
      final ukeTextFinder = find.text("Uke 39");
      expect(ukeTextFinder, findsOneWidget);
    });
  });

  testWidgets("WeeklyDatePicker works with swipe", (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
                selectedDay: clock.now(), changeDay: (value) => {})),
      );

      final pageViewFinder = find.byType(PageView);
      final nextWeekDateFinder = find.text("4");

      await tester.dragUntilVisible(
        nextWeekDateFinder,
        pageViewFinder,
        Offset(-250, 0),
      );

      expect(nextWeekDateFinder, findsOneWidget);
    });
  });

  testWidgets("WeeklyDatePicker works with leap years",
      (WidgetTester tester) async {
    final DateTime leapYearDateTime = DateTime(2020, 02, 27);

    withClock(Clock.fixed(leapYearDateTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
                selectedDay: leapYearDateTime, changeDay: (value) => {})),
      );

      final List<int> dates = [24, 25, 26, 27, 28, 29, 1];

      for (int date in dates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }

      expect(find.text("Week 9"), findsOneWidget);
    });
  });

  testWidgets("WeeklyDatePicker works over new year",
      (WidgetTester tester) async {
    final DateTime leapYearDateTime = DateTime(2020, 12, 30);

    withClock(Clock.fixed(leapYearDateTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
                selectedDay: leapYearDateTime, changeDay: (value) => {})),
      );

      final List<int> dates = [28, 29, 30, 31, 1, 2, 3];

      for (int date in dates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }

      expect(find.text("Week 53"), findsOneWidget);

      final pageViewFinder = find.byType(PageView);
      final nextWeekDateFinder = find.text("10");

      await tester.dragUntilVisible(
        nextWeekDateFinder,
        pageViewFinder,
        Offset(-250, 0),
      );

      expect(find.text("Week 54"), findsNothing);
      expect(find.text("Week 1"), findsOneWidget);

      final List<int> datesAfterScroll = [4, 5, 6, 7, 8, 9, 10];

      for (int date in datesAfterScroll) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }
    });
  });

  testWidgets("WeeklyDatePicker works backwards in time",
      (WidgetTester tester) async {
    withClock(Clock.fixed(defaultTime), () async {
      await tester.pumpWidget(
        MaterialApp(
            home: WeeklyDatePicker(
                selectedDay: clock.now(), changeDay: (value) => {})),
      );

      expect(find.text("Week 39"), findsOneWidget);

      final pageViewFinder = find.byType(PageView);
      final nextWeekDateFinder = find.text("21");

      await tester.dragUntilVisible(
        nextWeekDateFinder,
        pageViewFinder,
        Offset(250, 0),
      );

      expect(nextWeekDateFinder, findsOneWidget);

      final List<int> previousWeekDates = [20, 21, 22, 23, 24, 25, 26];
      for (int date in previousWeekDates) {
        final dateFinder = find.text(date.toString());
        expect(dateFinder, findsOneWidget);
      }

      expect(find.text("Week 38"), findsOneWidget);
      expect(find.text("Week 39"), findsNothing);
    });
  });
}
