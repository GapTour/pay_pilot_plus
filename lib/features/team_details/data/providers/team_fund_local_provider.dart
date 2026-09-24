import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_funds/team_funds_dao.dart';
import 'package:pay_pilot_plus/features/team_details/data/sources/i_team_fund_source.dart';

abstract class ITeamFundLocalProvider
    implements
        ITeamFundSource<
          TeamFundModel,
          int,
          List<TeamFundModel>,
          List<FundModel>
        > {}

class TeamFundLocalProvider implements ITeamFundLocalProvider {
  final TeamFundsDao _teamFundsDao;
  final FundsDao _fundsDao;

  TeamFundLocalProvider(this._fundsDao, this._teamFundsDao);

  @override
  Future<int> deleteFundRatio(int id) async {
    return _teamFundsDao.deleteFundRatio(id);
  }

  @override
  Future<List<TeamFundModel>> fetchAllTeamFunds(int teamID) async {
    final result = await _teamFundsDao.fetchAllTeamFunds(teamID);

    return result.map((e) {
      final teamFund = e.teamFund;
      final fund = e.fund;

      return TeamFundModel(
        id: teamFund.id,
        teamInfo: (id: teamID, name: 'No Name'),
        sharePercentage: teamFund.sharePercentage,
        fundInfo: (id: fund.id, name: fund.title),
      );
    }).toList();
  }

  @override
  Future<TeamFundModel> insertTeamFund(TeamFundParams params) async {
    final memberID = await _teamFundsDao.insertTeamFund(params);

    return TeamFundModel(
      id: memberID,
      teamInfo: params.teamInfo,
      sharePercentage: params.ratio,
      fundInfo: params.fundInfo,
    );
  }

  @override
  Future<TeamFundModel> updateFundRatio(TeamFundParams params) async {
    final memberID = await _teamFundsDao.updateFundRatio(params);

    return TeamFundModel(
      id: memberID,
      teamInfo: params.teamInfo,
      sharePercentage: params.ratio,
      fundInfo: params.fundInfo,
    );
  }

  @override
  Future<List<FundModel>> fetchAllFunds() async {
    final result = await _fundsDao.fetchAllActiveFunds();

    return result.map((e) {
      return FundModel(
        id: e.id,
        title: e.title,
        openingBalance: e.openingBalance,
        isActive: e.isActive,
      );
    }).toList();
  }
}
