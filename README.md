# Weekday Scroller

A weekday picker where you can scroll between weeks.

<img src="https://raw.githubusercontent.com/Magnuti/Weekday-Scroller/main/assets/white_with_week.gif">

## Custom styling

<img src="https://raw.githubusercontent.com/Magnuti/Weekday-Scroller/main/assets/white_without_week.gif">

<img src="https://raw.githubusercontent.com/Magnuti/Weekday-Scroller/main/assets/dark_with_week.gif">

<img src="https://raw.githubusercontent.com/Magnuti/Weekday-Scroller/main/assets/dark_five_day.gif">

## Installing

To use this package, add `weekday_scroller` as a dependency in your `pubspec.yaml` file.

## Usage

```dart
WeekdayScroller(
  selectedDay: _selectedDay, // DateTime
  changeDay: (value) => setState(() {
    _selectedDay = value;
  }),
),
```

## How to use custom styling

You can use custom colors and labels by the optional parameters:

- `weekdayText` Specifies the weekday text: default is 'Week'
- `weekdays` Specifies the weekday strings ['Mon', 'Tue'...]
- `backgroundColor` Background color
- `selectedColor` Color of the selected day circle
- `selectedTextColor` Color of the selected digits text
- `textColor` Color of the unselected digits text
- `weekdayColor` Is the color of the weekdays 'Mon', 'Tue'...
- `enableWeeknumberText` Set to false to hide the weeknumber textfield to the left of the slider
- `weeknumberColor` Color of the weekday container
- `weeknumberTextColor` Color of the weekday text
- `daysInWeek` Specifies the number of weekdays to render, default is 7, so Monday to Sunday
