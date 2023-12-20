# Weekly Date Picker

A weekday picker where you can scroll between weeks.

<img src="https://raw.githubusercontent.com/Magnuti/Weekly-Date-Picker/main/assets/white_with_week.gif">

## Custom styling

### You can remove the week text

<img src="https://raw.githubusercontent.com/Magnuti/Weekly-Date-Picker/main/assets/white_without_week.jpg" width="590">

### Add custom colors

<img src="https://raw.githubusercontent.com/Magnuti/Weekly-Date-Picker/main/assets/dark_without_week.jpg" width="590">

### You can also make only the weekdays selectable

<img src="https://raw.githubusercontent.com/Magnuti/Weekly-Date-Picker/main/assets/dark_five_days.jpg" width="590">

## Installing

To use this package, add `weekly_date_picker` as a dependency in your `pubspec.yaml` file.

## Usage

```dart
WeeklyDatePicker(
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
- `selectedDigitBackgroundColor` Color of the selected day circle
- `selectedDigitBorderColor` Color of the border of the selected day circle
- `selectedDigitColor` Color of the selected digit text
- `digitsColor` Color of the unselected digits text
- `weekdayTextColor` Is the color of the weekdays 'Mon', 'Tue'...
- `enableWeeknumberText` Set to false to hide the weeknumber textfield to the left of the slider
- `weeknumberColor` Color of the weekday container
- `weeknumberTextColor` Color of the weekday text
- `daysInWeek` Specifies the number of weekdays to render, default is 7, so Monday to Sunday
