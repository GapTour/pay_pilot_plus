import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/extensions/date_time_extension.dart';

part 'journals_dao.g.dart';

@DriftAccessor(tables: [JournalLines, JournalHeaders])
class JournalsDao extends DatabaseAccessor<AppDatabase>
    with _$JournalsDaoMixin {
  JournalsDao(super.db);

  Future<int> _insertHeader(JournalParams params) async {
    final nextDocNumber = await _generateNextAlphanumericEntryNumber(
      prefix: params.prefix,
      paddingLength: params.paddingLength,
    );

    final headerId = await into(journalHeaders).insert(
      JournalHeadersCompanion.insert(
        entryNumber: nextDocNumber,
        entryDate: params.date,
        description: Value(params.description),
        type: Value(params.type),
      ),
    );

    return headerId;
  }

  Future<int> insertJournal(JournalParams params) async {
    return await transaction(() async {
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

      final headerId = await _insertHeader(params);

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

  Future<int> insertOpeningJournal(List<JournalLinesCompanion> lines) async {
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

      final headerInfo =
          await (select(journalHeaders)
                ..where((tbl) => tbl.type.equals(JournalType.opening.name)))
              .getSingleOrNull();

      if (headerInfo != null) {
        await batch((batch) {
          batch.insertAll(
            journalLines,
            lines
                .map((l) => l.copyWith(headerId: Value(headerInfo.id)))
                .toList(),
          );
        });

        return headerInfo.id;
      }

      final headerId = await _insertHeader(
        JournalParams(
          date: DateTime.now().parseFirstDayOfYearInJalali,
          lines: lines,
          description: 'سند افتتاحیه برای حساب های دارای مانده از قبل',
          type: .opening,
        ),
      );

      await batch((batch) {
        batch.insertAll(
          journalLines,
          lines.map((l) => l.copyWith(headerId: Value(headerId))).toList(),
        );
      });

      return headerId;
    });
  }

  Future<List<JournalHeader>> fetchAllHeaders() async {
    return await select(journalHeaders).get();
  }

  Future<
    List<
      ({
        JournalLine journalLine,
        SubsidiaryAccount subAccount,
        AccountGroup group,
        GeneralAccount general,
        DetailedAccount? detailed1,
        DetailedAccount? detailed2,
      })
    >
  >
  fetchJournalLinesBySubsidiaryId({
    required int subsidiaryID,
    required int? firstDetailedID,
    int? secondDetailedID,
  }) async {
    final firstDetailed = alias(detailedAccounts, 'first_detailed');
    final secondDetailed = alias(detailedAccounts, 'second_detailed');

    final query = select(journalLines).join([
      innerJoin(
        subsidiaryAccounts,
        subsidiaryAccounts.id.equalsExp(journalLines.subsidiaryId),
      ),
      innerJoin(
        accountGroups,
        accountGroups.id.equalsExp(subsidiaryAccounts.accountGroupId),
      ),
      innerJoin(
        generalAccounts,
        generalAccounts.id.equalsExp(subsidiaryAccounts.generalAccountId),
      ),
      leftOuterJoin(
        firstDetailed,
        firstDetailed.id.equalsExp(journalLines.firstDetailedId),
      ),
      leftOuterJoin(
        secondDetailed,
        secondDetailed.id.equalsExp(journalLines.secondDetailedId),
      ),
    ]);

    // Build the where clause dynamically to handle optional parameters correctly,
    // avoiding unintended filtering by null when an argument isn't provided.
    Expression<bool> whereClause = journalLines.subsidiaryId.equals(
      subsidiaryID,
    );

    if (firstDetailedID != null) {
      whereClause &= journalLines.firstDetailedId.equals(firstDetailedID);
    } else {
      whereClause &= journalLines.firstDetailedId.isNull();
    }

    if (secondDetailedID != null) {
      whereClause &= journalLines.secondDetailedId.equals(secondDetailedID);
    } else {
      // If secondDetailedID is explicitly omitted (null), do not filter out rows
      // that contain a valid secondDetailedId. If you want to allow both null
      // and non-null values when secondDetailedID is not passed, omit this branch entirely.
      // If you only want rows where secondDetailedId is null, keep the else block.
    }

    query.where(whereClause);

    final results = await query.get();

    return results.map((row) {
      final line = row.readTable(journalLines);
      final subAccount = row.readTable(subsidiaryAccounts);
      final group = row.readTable(accountGroups);
      final general = row.readTable(generalAccounts);

      final detailed1 = row.readTableOrNull(firstDetailed);
      final detailed2 = row.readTableOrNull(secondDetailed);

      return (
        journalLine: line,
        subAccount: subAccount,
        group: group,
        general: general,
        detailed1: detailed1,
        detailed2: detailed2,
      );
    }).toList();
  }

  Future<
    List<
      ({
        JournalLine journalLine,
        SubsidiaryAccount subAccount,
        AccountGroup group,
        GeneralAccount general,
        DetailedAccount? detailed1,
        DetailedAccount? detailed2,
      })
    >
  >
  fetchJournalLinesByHeaderId(int headerID) async {
    final firstDetailed = alias(detailedAccounts, 'first_detailed');
    final secondDetailed = alias(detailedAccounts, 'second_detailed');

    final query = select(journalLines).join([
      innerJoin(
        subsidiaryAccounts,
        subsidiaryAccounts.id.equalsExp(journalLines.subsidiaryId),
      ),
      innerJoin(
        accountGroups,
        accountGroups.id.equalsExp(subsidiaryAccounts.accountGroupId),
      ),
      innerJoin(
        generalAccounts,
        generalAccounts.id.equalsExp(subsidiaryAccounts.generalAccountId),
      ),
      leftOuterJoin(
        firstDetailed,
        firstDetailed.id.equalsExp(journalLines.firstDetailedId),
      ),
      leftOuterJoin(
        secondDetailed,
        secondDetailed.id.equalsExp(journalLines.secondDetailedId),
      ),
    ])..where(journalLines.headerId.equals(headerID));

    final results = await query.get();

    return results.map((row) {
      final line = row.readTable(journalLines);
      final subAccount = row.readTable(subsidiaryAccounts);
      final group = row.readTable(accountGroups);
      final general = row.readTable(generalAccounts);

      final detailed1 = row.readTableOrNull(firstDetailed);
      final detailed2 = row.readTableOrNull(secondDetailed);

      return (
        journalLine: line,
        subAccount: subAccount,
        group: group,
        general: general,
        detailed1: detailed1,
        detailed2: detailed2,
      );
    }).toList();
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

      await (delete(
        journalLines,
      )..where((tbl) => tbl.headerId.equals(headerID))).go();

      await batch((batch) {
        batch.insertAll(
          journalLines,
          lines.map((l) => l.copyWith(headerId: Value(headerID))).toList(),
        );
      });

      return headerID;
    });
  }

  Future<int> deleteOpeningJournals({
    required int subsidiaryID,
    required int? firstDetailedId,
  }) async {
    final headerInfo =
        await (select(journalHeaders)
              ..where((tbl) => tbl.type.equals(JournalType.opening.name)))
            .getSingleOrNull();

    if (headerInfo == null) return subsidiaryID;

    final line =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.subsidiaryId.equals(subsidiaryID) &
                  tbl.firstDetailedId.equalsNullable(firstDetailedId) &
                  tbl.headerId.equals(headerInfo.id),
            ))
            .getSingleOrNull();

    if (line == null) return subsidiaryID;

    return await transaction(() async {
      await (delete(
        journalLines,
      )..where((tbl) => tbl.series.equals(line.series))).go();

      return subsidiaryID;
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

  Future<int> deleteJournalsLinesByHeaderDate({
    required int? subsidiaryID,
    required int firstDetailedId,
    int? secondDetailedId,
    required DateTime headerDate,
    BigInt? debit,
    BigInt? credit,
  }) async {
    final currentDebit = debit ?? BigInt.zero;
    final currentCredit = credit ?? BigInt.zero;

    final lines =
        await (select(journalLines)..where(
              (tbl) =>
                  tbl.debit.equals(currentDebit) &
                  tbl.credit.equals(currentCredit) &
                  tbl.firstDetailedId.equals(firstDetailedId) &
                  tbl.subsidiaryId.equalsNullable(subsidiaryID) &
                  tbl.secondDetailedId.equalsNullable(secondDetailedId),
            ))
            .get();

    final headerIDs = lines.map((e) => e.headerId).toSet();

    final targetHeader =
        await (select(journalHeaders)..where(
              (tbl) =>
                  tbl.entryDate.equals(headerDate) & tbl.id.isIn(headerIDs),
            ))
            .getSingleOrNull();

    if (targetHeader == null) {
      return throw StateError('سند مورد نظر پیدا نشد!');
    }

    return await transaction(() async {
      await (delete(
        journalLines,
      )..where((tbl) => tbl.headerId.equals(targetHeader.id))).go();

      return await (delete(
        journalHeaders,
      )..where((tbl) => tbl.id.equals(targetHeader.id))).go();
    });
  }

  Future<int> deleteJournalsLines(String series) async {
    return await transaction(() async {
      final lines = await (select(
        journalLines,
      )..where((tbl) => tbl.series.equals(series))).get();

      final deletedResult = await (delete(
        journalLines,
      )..where((tbl) => tbl.series.equals(series))).go();

      final existedLines = await (select(
        journalLines,
      )..where((tbl) => tbl.headerId.equals(lines.first.headerId))).get();

      if (existedLines.isNotEmpty) return deletedResult;

      return await (delete(
        journalHeaders,
      )..where((tbl) => tbl.id.equals(lines.first.headerId))).go();
    });
  }

  Future<List<JournalLine>?> fetchAllOpeningJournals() async {
    final query =
        (select(
          journalHeaders,
        )..where((tbl) => tbl.type.equals(JournalType.opening.name))).join([
          innerJoin(
            journalLines,
            journalLines.headerId.equalsExp(journalHeaders.id),
          ),
        ]);

    final rows = await query.get();

    final lines = <JournalLine>[];
    for (var row in rows) {
      final result = row.readTableOrNull(journalLines);
      if (result != null) lines.add(result);
    }

    return lines.isEmpty ? null : lines;
  }

  Future<List<JournalLine>> fetchJournals({
    required int? subsidiaryID,
    required int firstDetailedId,
    int? secondDetailedId,
  }) async {
    return await (select(journalLines)..where(
          (tbl) =>
              tbl.firstDetailedId.equals(firstDetailedId) &
              tbl.subsidiaryId.equalsNullable(subsidiaryID) &
              tbl.secondDetailedId.equalsNullable(secondDetailedId),
        ))
        .get();
  }

  Future<List<JournalLine>> fetchJournalsBySeries({
    required String series,
  }) async {
    return await (select(
      journalLines,
    )..where((tbl) => tbl.series.equals(series))).get();
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
