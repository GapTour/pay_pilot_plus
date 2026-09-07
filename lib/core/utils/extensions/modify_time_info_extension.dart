extension ModifyTimeInfoExtension on DateTime {
  DateTime get removeTime =>
      copyWith(hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);

  DateTime get addEndOfTheDayTime => copyWith(
    hour: 23,
    minute: 59,
    second: 59,
    microsecond: 59,
    millisecond: 59,
  );
}
