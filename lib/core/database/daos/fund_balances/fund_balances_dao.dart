import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/fund_balance_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'fund_balances_dao.g.dart';

@DriftAccessor(tables: [Funds, FundBalances])
class FundBalancesDao extends DatabaseAccessor<AppDatabase>
    with _$FundBalancesDaoMixin {
  FundBalancesDao(super.db);

  Future<int> insertBalance(FundBalanceParams params) async {
    return await transaction(() async {
      return await into(fundBalances).insert(
        FundBalancesCompanion(
          fundID: Value(params.fundID),
          eventID: Value(params.eventID),
          debit: Value(params.debit),
          credit: Value(params.credit),
          date: Value(params.date),
        ),
      );
    });
  }

  Future<List<({FundBalance balance, Fund fund, Event event})>>
  fetchAllBalances(int fundID) async {
    final query =
        (select(fundBalances)..where((tbl) => tbl.fundID.equals(fundID))).join([
          innerJoin(funds, funds.id.equalsExp(fundBalances.fundID)),
          innerJoin(events, events.id.equalsExp(fundBalances.eventID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final balance = row.readTable(fundBalances);
      final fund = row.readTable(funds);
      final event = row.readTable(events);

      return (balance: balance, fund: fund, event: event);
    }).toList();
  }

  Future<FundBalance> fetchBalance(int id) async {
    return await (select(
      fundBalances,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateBalance(FundBalanceParams params) async {
    return await transaction(() async {
      return await (update(
        fundBalances,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        FundBalancesCompanion(
          fundID: Value(params.fundID),
          eventID: Value(params.eventID),
          debit: Value(params.debit),
          credit: Value(params.credit),
          date: Value(params.date),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> deleteBalance(int eventID) async {
    return await (db.delete(
      fundBalances,
    )..where((tbl) => tbl.eventID.equals(eventID))).go();
  }
}
