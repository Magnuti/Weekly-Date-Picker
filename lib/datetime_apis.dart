extension CompareDates on DateTime {
  bool isSameDateAs(DateTime other) {
    return this.day == other.day &&
        this.month == other.month &&
        this.year == other.year;
  }

  DateTime addDays(int days) {
    return DateTime(this.year, this.month, this.day + days);
  }
}
