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

  Future<({List<FundBalance> balances, Event? event})>
  fetchSpecificFundBalances(int fundID) async {
    final rows =
        await (select(
          fundBalances,
        )..where((tbl) => tbl.fundID.equals(fundID))).join([
          leftOuterJoin(events, events.id.equalsExp(fundBalances.eventID)),
        ]).get();

    final event = rows.isNotEmpty ? rows.first.readTableOrNull(events) : null;

    final balances = rows
        .map((row) => row.readTableOrNull(fundBalances))
        .whereType<FundBalance>()
        .toList();

    return (balances: balances, event: event);
  }

  Future<List<({List<FundBalance> balances, Fund fund, Event? event})>>
  fetchAllBalances() async {
    final allFunds = await select(funds).get();

    return Future.wait(
      allFunds.map((fund) async {
        final rows =
            await (select(
              fundBalances,
            )..where((tbl) => tbl.fundID.equals(fund.id))).join([
              leftOuterJoin(events, events.id.equalsExp(fundBalances.eventID)),
            ]).get();

        final event = rows.isNotEmpty
            ? rows.first.readTableOrNull(events)
            : null;

        final balances = rows
            .map((row) => row.readTableOrNull(fundBalances))
            .whereType<FundBalance>()
            .toList();

        return (balances: balances, fund: fund, event: event);
      }),
    );
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
