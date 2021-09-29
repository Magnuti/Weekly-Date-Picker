extension CompareDates on DateTime {
  bool isSameDateAs(DateTime other) {
    return this.day == other.day &&
        this.month == other.month &&
        this.year == other.year;
  }
}
