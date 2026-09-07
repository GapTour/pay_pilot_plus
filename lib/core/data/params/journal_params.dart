import 'package:pay_pilot_plus/core/database/app_database.dart';

class JournalParams {
  final DateTime date;
  final List<JournalLinesCompanion> lines;
  final String prefix;
  final int paddingLength;
  final String? description;
  final JournalType type;
  final int? headerID;

  JournalParams({
    required this.date,
    required this.lines,
    this.prefix = 'JV-',
    this.paddingLength = 4,
    this.description,
    this.headerID,
    this.type = JournalType.normal,
  });
}
