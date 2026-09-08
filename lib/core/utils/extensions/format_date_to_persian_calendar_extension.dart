import 'package:persian_calendar_widget/persian_calendar_widget.dart';

extension FormatDateToPersianCalendarExtension on DateTime {
  String get formattedToJalali_yearMonth =>
      '${toJalali().formatter.mN} ${toJalali().formatter.yyyy}';
  String get formattedToJalali_yearMonthDay =>
      '${toJalali().formatter.dd} ${toJalali().formatter.mN} ${toJalali().formatter.yyyy}';
  String get formattedToJalali_yearMonthDayWeekDay =>
      '${toJalali().formatter.wNFn} - ${toJalali().formatter.dd} ${toJalali().formatter.mN} ${toJalali().formatter.yyyy}';
}
