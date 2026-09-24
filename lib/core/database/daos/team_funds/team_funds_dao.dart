import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'team_funds_dao.g.dart';

@DriftAccessor(tables: [TeamFunds, Teams, Funds])
class TeamFundsDao extends DatabaseAccessor<AppDatabase>
    with _$TeamFundsDaoMixin {
  TeamFundsDao(super.db);

  Future<int> insertTeamFund(TeamFundParams params) async {
    return await transaction(() async {
      return await into(teamFunds).insert(
        TeamFundsCompanion(
          sharePercentage: Value(params.ratio),
          teamID: Value(params.teamInfo.id),
          fundID: Value(params.fundInfo.id),
        ),
      );
    });
  }

  Future<List<({TeamFund teamFund, Fund fund})>> fetchAllTeamFunds(
    int teamID,
  ) async {
    final query = (select(teamFunds)..where((tbl) => tbl.teamID.equals(teamID)))
        .join([innerJoin(funds, funds.id.equalsExp(teamFunds.fundID))]);

    final rows = await query.get();

    return rows.map((row) {
      final teamFund = row.readTable(teamFunds);
      final fund = row.readTable(funds);

      return (teamFund: teamFund, fund: fund);
    }).toList();
  }

  Future<int> updateFundRatio(TeamFundParams params) async {
    return await transaction(() async {
      return await (update(teamFunds)
            ..where((tbl) => tbl.id.equals(params.id!)))
          .write(TeamFundsCompanion(sharePercentage: Value(params.ratio)));
    });
  }

  Future<int> deleteFundRatio(int id) async {
    return await transaction(() async {
      return await (delete(teamFunds)..where((tbl) => tbl.id.equals(id))).go();
    });
  }
}
