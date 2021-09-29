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
}
