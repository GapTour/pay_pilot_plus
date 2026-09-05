import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'banks_dao.g.dart';

@DriftAccessor(tables: [Banks, DetailedAccounts])
class BanksDao extends DatabaseAccessor<AppDatabase> with _$BanksDaoMixin {
  BanksDao(super.db);

  Future<int> insertBank(BankParams params) async {
    final existingName = await (select(
      banks,
    )..where((tbl) => tbl.name.equals(params.name.trim()))).getSingleOrNull();

    if (existingName != null) {
      return throw StateError(
        'نام ${params.name} تکراری است، نام دیگری ثبت کنید.',
      );
    }

    return await transaction(() async {
      return await db
          .into(banks)
          .insert(
            BanksCompanion(
              name: Value(params.name.trim()),
              number: Value(params.number),
              description: Value(params.description),
            ),
          );
    });
  }

  Future<List<({Bank bank, DetailedAccount account})>> fetchAllBanks() async {
    final query = select(detailedAccounts)
        .join([innerJoin(banks, banks.id.equalsExp(detailedAccounts.bankID))]);

    final rows = await query.get();

    return rows.map((e) {
      final bank = e.readTable(banks);
      final account = e.readTable(detailedAccounts);

      return (bank: bank, account: account);
    }).toList();
  }

  Future<int> updateBank(BankParams params) async {
    final existingName = await (select(
      banks,
    )..where((tbl) => tbl.name.equals(params.name.trim()))).getSingleOrNull();

    if (existingName != null && existingName.id != params.id) {
      return throw StateError(
        'نام ${params.name} تکراری است، نام دیگری ثبت کنید.',
      );
    }

    return await transaction(() async {
      return await (update(
        banks,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        BanksCompanion(
          name: Value(params.name),
          number: Value(params.number),
          description: Value(params.description),
          isActive: Value(params.isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> archiveBank(int id) async {
    return await transaction(() async {
      return await (update(banks)..where((tbl) => tbl.id.equals(id))).write(
        BanksCompanion(
          isActive: Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  // Future<void> deleteUser(int id) async {
  //   await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  // }
}
