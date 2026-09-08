extension ParseStringToExtension on String {
  int get parseStringToInt =>
      this != '' && this != 'null' ? int.parse(this) : 0;

  int? get parseStringToNullableInt =>
      this != '' && this != 'null' ? int.parse(this) : null;

  double get parseStringToDouble =>
      this != '' && this != 'null' ? double.parse(this) : 0.0;

  double? get parseStringToNullableDouble =>
      this != '' && this != 'null' ? double.parse(this) : null;

  DateTime get parseStringToDate => DateTime.parse(this);

  DateTime? get parseStringToNullableDate =>
      this != '' && this != 'null' ? DateTime.parse(this) : null;

  bool get parseStringToBoolean => this == '1' || this == 'true' ? true : false;
}

extension ParseNullStringToDataTypesExtension on String? {
  int get parseStringToInt =>
      this != '' && this != 'null' ? int.parse(this ?? '0') : 0;

  int? get parseStringToNullableInt => this != null
      ? this != '' && this != 'null'
            ? int.parse(this!)
            : null
      : null;

  double get parseStringToDouble =>
      this != '' && this != 'null' ? double.parse(this ?? '0.0') : 0.0;

  double? get parseStringToNullableDouble => this != null
      ? this != '' && this != 'null'
            ? double.parse(this!)
            : null
      : null;

  DateTime? get parseStringToNullableDate => this != null
      ? this != '' && this != 'null'
            ? DateTime.parse(this!)
            : null
      : null;

  bool get parseStringToBoolean => this == '1' || this == 'true' ? true : false;

  bool? get parseStringToNullableBoolean => this != null
      ? this == '1' || this == 'true'
            ? true
            : false
      : null;
}
