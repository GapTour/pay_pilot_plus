// ignore: depend_on_referenced_packages
import 'package:shamsi_date/shamsi_date.dart';

extension DateTimeExtension on DateTime {
  DateTime get parseFirstDayOfYearInJalali {
    final now = toJalali();
    final firstDayOfYear = Jalali(now.year, 1, 1);

    return firstDayOfYear.toDateTime();
  }
}
