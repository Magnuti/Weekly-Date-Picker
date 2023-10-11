import 'package:flutter_test/flutter_test.dart';
import "package:weekly_date_picker/datetime_apis.dart";

void main() {
  group("DateTime extension should compare dates only ", () {
    test("Dates should be equal", () {
      DateTime d1 = new DateTime(2020, 2, 2);
      DateTime d2 = new DateTime(2020, 2, 2);

      expect(d1.isSameDateAs(d2), true);
    });

    test("Dates should be equal", () {
      DateTime d1 = new DateTime(2020, 2, 2, 17, 30);
      DateTime d2 = new DateTime(2020, 2, 2, 10, 20);

      expect(d1.isSameDateAs(d2), true);
    });

    test("Dates should be unequal", () {
      DateTime d1 = new DateTime(2020, 2, 3);
      DateTime d2 = new DateTime(2020, 2, 2);

      expect(d1.isSameDateAs(d2), false);
    });

    test("Dates should be unequal", () {
      DateTime d1 = new DateTime(2020, 5, 2);
      DateTime d2 = new DateTime(2020, 1, 2);

      expect(d1.isSameDateAs(d2), false);
    });

    test("Dates should be unequal", () {
      DateTime d1 = new DateTime(2019, 1, 1, 17, 30);
      DateTime d2 = new DateTime(2020, 1, 1, 10, 20);

      expect(d1.isSameDateAs(d2), false);
    });
  });

  group("DateTime addDate extension should work ", () {
    test("Add dates should work", () {
      DateTime date = new DateTime(2023, 1, 1);
      expect(date.addDays(1).isSameDateAs(DateTime(2023, 1, 2)), true);
      expect(date.addDays(30).isSameDateAs(DateTime(2023, 1, 31)), true);
      expect(date.addDays(31).isSameDateAs(DateTime(2023, 2, 1)), true);
    });

    test("Add dates should work with daylight savings", () {
      DateTime date = new DateTime(2023, 10, 29);
      expect(date.addDays(1).isSameDateAs(DateTime(2023, 10, 30)), true);

      // This one should fail since that date is daylight savings in Europe
      expect(date.add(Duration(days: 1)).isSameDateAs(DateTime(2023, 10, 30)),
          false);
    });

    test("Add dates should works over new year", () {
      DateTime date = new DateTime(2020, 12, 30);
      expect(date.addDays(2).isSameDateAs(DateTime(2021, 1, 1)), true);
    });
  });
}
