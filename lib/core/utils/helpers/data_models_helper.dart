class DataModelsHelper {
  DataModelsHelper._();

  static ({int id, String name}) parseInfo(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      return (
        id: (raw['id'] as num).toInt(),
        name: raw['name'] as String? ?? '',
      );
    } else if (raw is ({int id, String name})) {
      return raw;
    }
    throw FormatException('Invalid info payload: $raw');
  }

  static ({int id, String name, String code}) parseDetailedAccountInfo(
    dynamic raw,
  ) {
    if (raw is Map<String, dynamic>) {
      return (
        id: (raw['id'] as num).toInt(),
        name: raw['name'] as String? ?? '',
        code: raw['code'] as String? ?? '',
      );
    } else if (raw is ({int id, String name, String code})) {
      return raw;
    }
    throw FormatException('Invalid detailedAccountInfo payload: $raw');
  }
}
