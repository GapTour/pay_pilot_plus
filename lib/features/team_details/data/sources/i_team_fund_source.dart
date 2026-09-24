import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';

abstract class ITeamFundSource<TRatio, TInt, TList, TFunds> {
  Future<TRatio> insertTeamFund(TeamFundParams params);
  Future<TInt> deleteFundRatio(int id);
  Future<TList> fetchAllTeamFunds(int teamID);
  Future<TFunds> fetchAllFunds();
  Future<TRatio> updateFundRatio(TeamFundParams params);
}
