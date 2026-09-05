import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'detailed_accounts_dao.g.dart';

@DriftAccessor(tables: [DetailedAccounts])
class DetailedAccountsDao extends DatabaseAccessor<AppDatabase>
    with _$DetailedAccountsDaoMixin {
  DetailedAccountsDao(super.db);

  Future<({int id, String code})> insertAccount(
    DetailedAccountParams params,
  ) async {
    // ۱. اعتبارسنجی یکپارچگی داده‌ها بر اساس نوع حساب
    _validateTypeRelations(params.type, attachmentID: params.attachmentID);

    // ۲. نگاشت پیشوند کد بر اساس نوع حساب تفصیلی
    final String prefix = switch (params.type) {
      DetailedAccountType.user => '10',
      DetailedAccountType.event => '20',
      DetailedAccountType.bank => '30',
      DetailedAccountType.cash => '40',
      DetailedAccountType.other => '90',
    };

    // ۳. استخراج بزرگترین کد ثبت‌شده با پیشوند مربوطه (معادلی برای Atomic Max Sequence)
    final query = selectOnly(detailedAccounts)
      ..addColumns([detailedAccounts.code])
      ..where(detailedAccounts.code.like('$prefix%'))
      ..orderBy([
        OrderingTerm(
          expression: detailedAccounts.code,
          mode: OrderingMode.desc,
        ),
      ])
      ..limit(1);

    final lastCode = await query
        .map((row) => row.read(detailedAccounts.code))
        .getSingleOrNull();

    // ۴. محاسبه کد جدید (مثلاً 100001)
    final String newCode;
    if (lastCode == null || lastCode.length <= prefix.length) {
      newCode = '${prefix}00001';
    } else {
      final currentSeq = int.tryParse(lastCode.substring(prefix.length)) ?? 0;
      final nextSeq = currentSeq + 1;
      newCode = '$prefix${nextSeq.toString().padLeft(5, '0')}';
    }

    return await transaction(() async {
      // ۵. درج اتمیک در دیتابیس
      final companion = DetailedAccountsCompanion.insert(
        code: newCode,
        name: params.name.trim(),
        type: params.type,
        userID: params.type.isUser
            ? Value(params.attachmentID)
            : Value.absent(),
        eventID: params.type.isEvent
            ? Value(params.attachmentID)
            : Value.absent(),
        bankID: params.type.isBank
            ? Value(params.attachmentID)
            : Value.absent(),
      );

      final newAccountID = await into(detailedAccounts).insert(companion);

      return (id: newAccountID, code: newCode);
    });
  }

  Future<List<DetailedAccount>> fetchAllAccounts() async {
    return select(detailedAccounts).get();
  }

  Future<DetailedAccount> fetchUserAccount(int userID) async {
    return await (select(
      detailedAccounts,
    )..where((tbl) => tbl.userID.equals(userID))).getSingle();
  }

  Future<List<DetailedAccount>> fetchAllUserAccounts() async {
    return await (select(
      detailedAccounts,
    )..where((tbl) => tbl.type.equals(DetailedAccountType.user.name))).get();
  }

  Future<DetailedAccount> fetchBankAccount(int bankID) async {
    return await (select(
      detailedAccounts,
    )..where((tbl) => tbl.bankID.equals(bankID))).getSingle();
  }

  Future<DetailedAccount> fetchEventAccount(int eventID) async {
    return await (select(
      detailedAccounts,
    )..where((tbl) => tbl.eventID.equals(eventID))).getSingle();
  }

  Future<int> updateAccount(DetailedAccountParams params) async {
    return await transaction(() async {
      return await (db.update(
        detailedAccounts,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        DetailedAccountsCompanion(
          name: Value(params.name),
          isActive: Value(params.isActive),
        ),
      );
    });
  }

  Future<int> archiveAccount(int id) async {
    return await transaction(() async {
      return await (db.update(detailedAccounts)
            ..where((tbl) => tbl.id.equals(id)))
          .write(DetailedAccountsCompanion(isActive: Value(false)));
    });
  }

  // Future<void> deleteUser(int id) async {
  //   await (db.delete(users)..where((tbl) => tbl.id.equals(id))).go();
  // }

  void _validateTypeRelations(DetailedAccountType type, {int? attachmentID}) {
    if (type.isUser && attachmentID == null) {
      throw ArgumentError(
        'برای حساب نوع user، مقدار userID نمی‌تواند نال باشد.',
      );
    }
    if (type.isEvent && attachmentID == null) {
      throw ArgumentError(
        'برای حساب نوع event، مقدار eventID نمی‌تواند نال باشد.',
      );
    }
    if (type.isBank && attachmentID == null) {
      throw ArgumentError(
        'برای حساب نوع bank، مقدار bankID نمی‌تواند نال باشد.',
      );
    }
  }
}
