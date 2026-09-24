import 'dart:math';

class JournalLinesSeriesHelper {
  static final Random _random = Random.secure();
  static const String _characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  static String generateSeries({String? extra}) {
    final date = DateTime.now().toUtc();
    final datePart =
        '${date.year}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}'
        '${date.hour.toString().padLeft(2, '0')}'
        '${date.minute.toString().padLeft(2, '0')}'
        '${date.second.toString().padLeft(2, '0')}';

    final randomPart = List.generate(
      8,
      (_) => _characters[_random.nextInt(_characters.length)],
    ).join();

    return 'SER-$datePart-$randomPart${extra != null ? '-$extra' : 'N'}';
  }
}
