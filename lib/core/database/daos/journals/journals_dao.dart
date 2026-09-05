import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'journals_dao.g.dart';

@DriftAccessor(tables: [JournalLines, JournalHeaders])
class JournalsDao extends DatabaseAccessor<AppDatabase>
    with _$JournalsDaoMixin {
  JournalsDao(super.db);

  Future<int> insertJournal(JournalParams params) async {
    return await transaction(() async {
      // ۱. اعتبارسنجی تراز بودن سند
      BigInt totalDebit = BigInt.zero;
      BigInt totalCredit = BigInt.zero;

      for (final line in params.lines) {
        totalDebit += line.debit.value;
        totalCredit += line.credit.value;
      }

      if (totalDebit != totalCredit) {
        throw StateError(
          'عدم تراز سند: مجموع بدهکار ($totalDebit) با بستانکار ($totalCredit) برابر نیست.',
        );
      }

      if (params.headerID != null) {
        await batch((batch) {
          batch.insertAll(
            journalLines,
            params.lines
                .map((l) => l.copyWith(headerId: Value(params.headerID!)))
                .toList(),
          );
        });

        return params.headerID!;
      }

      // ۲. تولید شماره سند ترکیبی جدید در داخل قفل تراکنش
      final nextDocNumber = await _generateNextAlphanumericEntryNumber(
        prefix: params.prefix,
        paddingLength: params.paddingLength,
      );

      // ۳. درج هدر سند
      final headerId = await into(journalHeaders).insert(
        JournalHeadersCompanion.insert(
          entryNumber: nextDocNumber,
          entryDate: params.date,
          description: Value(params.description),
          type: Value(params.type),
        ),
      );

      // ۴. درج دسته‌ای (Batch) ردیف‌های سند
      await batch((batch) {
        batch.insertAll(
          journalLines,
          params.lines
              .map((l) => l.copyWith(headerId: Value(headerId)))
              .toList(),
        );
      });

      return headerId;
    });
  }

  Future<int> updateJournal({
    required int headerID,
    required List<JournalLinesCompanion> lines,
  }) async {
    return await transaction(() async {
      BigInt totalDebit = BigInt.zero;
      BigInt totalCredit = BigInt.zero;

      for (final line in lines) {
        totalDebit += line.debit.value;
        totalCredit += line.credit.value;
      }

      if (totalDebit != totalCredit) {
        throw StateError(
          'عدم تراز سند: مجموع بدهکار ($totalDebit) با بستانکار ($totalCredit) برابر نیست.',
        );
      }

      await batch((batch) {
        batch.insertAll(
          journalLines,
          lines.map((l) => l.copyWith(headerId: Value(headerID))).toList(),
        );
      });

      return headerID;
    });
  }

  Future<int> deleteJournalHeader(int headerID) async {
    return await transaction(() async {
      await (delete(
        journalLines,
      )..where((tbl) => tbl.headerId.equals(headerID))).go();

      return await (delete(
        journalHeaders,
      )..where((tbl) => tbl.id.equals(headerID))).go();
    });
  }

  Future<int> deleteJournalsLines(String series) async {
    return await transaction(() async {
      await (delete(
        journalLines,
      )..where((tbl) => tbl.series.equals(series))).go();

      final headers = await (select(
        journalLines,
      )..where((tbl) => tbl.series.equals(series))).get();

      if (headers.isNotEmpty) return headers.first.headerId;

      return await (delete(
        journalHeaders,
      )..where((tbl) => tbl.id.equals(headers.first.headerId))).go();
    });
  }

  Future<List<JournalLine>> fetchJournals(int detailedAccountID) async {
    return await (select(
      journalLines,
    )..where((tbl) => tbl.detailedId.equals(detailedAccountID))).get();
  }

  Future<String> findRegistrationJournalSeries(
    int eventAccountID,
    int userAccountID,
  ) async {
    final String extra = 'regUSR${userAccountID}EVN$eventAccountID';

    final journalInfo =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.detailedId.equals(eventAccountID) &
                  tbl.debit.equals(BigInt.zero) &
                  tbl.series.contains(extra),
            ))
            .getSingle();

    return journalInfo.series;
  }

  Future<String> findPaymentJournalSeries(
    int eventAccountID,
    int userAccountID,
  ) async {
    final String extra = 'payUSR${userAccountID}EVN$eventAccountID';

    final journalInfo =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.detailedId.equals(userAccountID) &
                  tbl.debit.equals(BigInt.zero) &
                  tbl.series.contains(extra),
            ))
            .getSingle();

    return journalInfo.series;
  }

  Future<int?> fetchDebitJournalsHeader({
    int? detailedAccountID,
    int? detailedSecondAccountID,
    required int subsidiaryID,
  }) async {
    final lines =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.subsidiaryId.equals(subsidiaryID) &
                  tbl.detailedId.equalsNullable(detailedAccountID) &
                  tbl.detailedIdSecond.equalsNullable(detailedSecondAccountID) &
                  tbl.credit.equals(BigInt.zero),
            ))
            .get();

    return lines.isEmpty ? null : lines.first.headerId;
  }

  Future<int?> fetchCreditJournalsHeader({
    int? detailedAccountID,
    int? detailedSecondAccountID,
    required int subsidiaryID,
  }) async {
    final lines =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.subsidiaryId.equals(subsidiaryID) &
                  tbl.detailedId.equalsNullable(detailedAccountID) &
                  tbl.detailedIdSecond.equalsNullable(detailedSecondAccountID) &
                  tbl.debit.equals(BigInt.zero),
            ))
            .get();

    return lines.isEmpty ? null : lines.first.headerId;
  }

  Future<String> _generateNextAlphanumericEntryNumber({
    String prefix = 'JV-',
    int paddingLength = 4,
    int startSequence = 1,
  }) async {
    // استخراج آخرین شماره سندی که با پیشوند مورد نظر شروع می‌شود
    final query = selectOnly(journalHeaders)
      ..addColumns([journalHeaders.entryNumber])
      ..where(journalHeaders.entryNumber.like('$prefix%'))
      ..orderBy([
        OrderingTerm(
          expression: journalHeaders.entryNumber,
          mode: OrderingMode.desc,
        ),
      ])
      ..limit(1);

    final lastDocNumber = await query
        .map((row) => row.read(journalHeaders.entryNumber))
        .getSingleOrNull();

    if (lastDocNumber == null || lastDocNumber.length <= prefix.length) {
      final initialSeq = startSequence.toString().padLeft(paddingLength, '0');
      return '$prefix$initialSeq';
    }

    // جداسازی بخش عددی از انتهای رشته و افزایش آن
    final numericPartStr = lastDocNumber.substring(prefix.length);
    final currentSeq = int.tryParse(numericPartStr) ?? (startSequence - 1);
    final nextSeq = currentSeq + 1;

    return '$prefix${nextSeq.toString().padLeft(paddingLength, '0')}';
  }
}
