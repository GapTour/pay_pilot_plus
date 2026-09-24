import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'funds_dao.g.dart';

@DriftAccessor(tables: [Funds])
class FundsDao extends DatabaseAccessor<AppDatabase> with _$FundsDaoMixin {
  FundsDao(super.db);

  Future<int> insertFund(FundParams params) async {
    return await transaction(() async {
      return await into(funds).insert(
        FundsCompanion(
          title: Value(params.title),
          openingBalance: Value(params.openingBalance ?? BigInt.zero),
        ),
      );
    });
  }

  Future<List<Fund>> fetchAllActiveFunds() async {
    return await (select(
      funds,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  Future<Fund> fetchFund(int id) async {
    return await (select(funds)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateFund(FundParams params) async {
    return await transaction(() async {
      return await (update(
        funds,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        FundsCompanion(
          title: Value(params.title),
          openingBalance: Value(params.openingBalance ?? BigInt.zero),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> archiveFund(int id) async {
    return await transaction(() async {
      return await (update(funds)..where((tbl) => tbl.id.equals(id))).write(
        FundsCompanion(
          isActive: Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  // Future<void> deleteTeam(int id) async {
  //   await (db.delete(teams)..where((tbl) => tbl.id.equals(id))).go();
  // }
}
