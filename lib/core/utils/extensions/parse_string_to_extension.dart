extension ParseStringToExtension on String {
  int get parseStringToInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? int.parse(westernDigits) : 0;
  }

  int? get parseStringToNullableInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? int.parse(westernDigits) : null;
  }

  BigInt get parseStringToBigInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null'
        ? BigInt.tryParse(westernDigits) ?? BigInt.zero
        : BigInt.zero;
  }

  BigInt? get parseStringToNullableBigInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? BigInt.parse(westernDigits) : null;
  }

  double get parseStringToDouble {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? double.parse(westernDigits) : 0.0;
  }

  double? get parseStringToNullableDouble {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? double.parse(westernDigits) : null;
  }

  DateTime get parseStringToDate => DateTime.parse(this);

  DateTime? get parseStringToNullableDate =>
      this != '' && this != 'null' ? DateTime.parse(this) : null;

  bool get parseStringToBoolean {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits == '1' || this == 'true' ? true : false;
  }

  bool? get parseStringToNullableBoolean {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null'
        ? westernDigits == '1' || this == 'true'
              ? true
              : false
        : null;
  }

  String get parseStringToStringWithWesternDigits {
    return _formatToWesternDigits(this);
  }

  String? get parseNullIfIsEmpty => (isEmpty ? null : this);

  String get parseDashIfIsEmpty => (isEmpty ? '-' : this);

  String _formatToWesternDigits(String value) {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const westernDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String westernized = this;
    for (int i = 0; i < persianDigits.length; i++) {
      westernized = westernized.replaceAll(persianDigits[i], westernDigits[i]);
    }

    return westernized;
  }
}

extension ParseNullStringToDataTypesExtension on String? {
  int get parseStringToInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null' ? int.parse(westernDigits ?? '0') : 0;
  }

  int? get parseStringToNullableInt {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits != null
        ? this != '' && this != 'null'
              ? int.parse(westernDigits)
              : null
        : null;
  }

  BigInt get parseStringToBigInt {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null'
        ? BigInt.tryParse(westernDigits ?? '') ?? BigInt.zero
        : BigInt.zero;
  }

  BigInt? get parseStringToNullableBigInt {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits != null
        ? this != '' && this != 'null'
              ? BigInt.parse(westernDigits)
              : null
        : null;
  }

  double get parseStringToDouble {
    final westernDigits = _formatToWesternDigits(this);
    return this != '' && this != 'null'
        ? double.parse(westernDigits ?? '0.0')
        : 0.0;
  }

  double? get parseStringToNullableDouble {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits != null
        ? this != '' && this != 'null'
              ? double.parse(westernDigits)
              : null
        : null;
  }

  DateTime? get parseStringToNullableDate => this != null
      ? this != '' && this != 'null'
            ? DateTime.parse(this!)
            : null
      : null;

  bool get parseStringToBoolean {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits == '1' || this == 'true' ? true : false;
  }

  bool? get parseStringToNullableBoolean {
    final westernDigits = _formatToWesternDigits(this);
    return westernDigits != null
        ? westernDigits == '1' || this == 'true'
              ? true
              : false
        : null;
  }

  String? get parseStringToStringWithWesternDigits {
    return _formatToWesternDigits(this);
  }

  String? get parseNullIfIsEmpty =>
      this == null ? null : (this!.isEmpty ? null : this);

  String? get parseDashIfIsEmpty =>
      this == null ? '-' : (this!.isEmpty ? '-' : this);

  String? _formatToWesternDigits(String? value) {
    if (this == null) return null;
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const westernDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String westernized = this!;
    for (int i = 0; i < persianDigits.length; i++) {
      westernized = westernized.replaceAll(persianDigits[i], westernDigits[i]);
    }

    return westernized;
  }
}
