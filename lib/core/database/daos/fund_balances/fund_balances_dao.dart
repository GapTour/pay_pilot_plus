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
          memo: Value(params.memo),
          series: Value(params.series),
          debit: Value(params.debit),
          credit: Value(params.credit),
          date: Value(params.date),
        ),
      );
    });
  }

  Future<List<FundBalance>> fetchSpecificFundBalances(int fundID) async {
    return await (select(
      fundBalances,
    )..where((tbl) => tbl.fundID.equals(fundID))).get();
  }

  Future<List<({List<FundBalance> balances, Fund fund})>>
  fetchAllBalances() async {
    final allFunds = await select(funds).get();

    return Future.wait(
      allFunds.map((fund) async {
        final balances = await (select(
          fundBalances,
        )..where((tbl) => tbl.fundID.equals(fund.id))).get();

        return (balances: balances, fund: fund);
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
          memo: Value(params.memo),
          series: Value(params.series),
          debit: Value(params.debit),
          credit: Value(params.credit),
          date: Value(params.date),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> deleteBalance(String series) async {
    return await (db.delete(
      fundBalances,
    )..where((tbl) => tbl.series.equals(series))).go();
  }
}
