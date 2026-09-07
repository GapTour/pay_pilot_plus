extension ParseNullValueExtension on String? {
  String? get parseNullIfIsEmpty =>
      this == null ? null : (this!.isEmpty ? null : this);

  String? get parseDashIfIsEmpty =>
      this == null ? '-' : (this!.isEmpty ? '-' : this);
}
