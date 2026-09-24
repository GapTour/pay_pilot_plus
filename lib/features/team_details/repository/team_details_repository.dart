import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/team_details/data/providers/team_fund_local_provider.dart';
import 'package:pay_pilot_plus/features/team_details/data/providers/team_member_local_provider.dart';
import 'package:pay_pilot_plus/features/team_details/data/sources/i_team_fund_source.dart';
import 'package:pay_pilot_plus/features/team_details/data/sources/i_team_member_source.dart';

abstract class ITeamDetailsRepository
    implements
        ITeamMemberSource<
          DataState<TeamMemberModel>,
          DataState<int>,
          DataState<List<TeamMemberModel>>,
          DataState<List<UserModel>>
        >,
        ITeamFundSource<
          DataState<TeamFundModel>,
          DataState<int>,
          DataState<List<TeamFundModel>>,
          DataState<List<FundModel>>
        > {}

class TeamDetailsRepository extends BaseRepository
    implements ITeamDetailsRepository {
  final ITeamMemberLocalProvider _memberLocalProvider;
  final ITeamFundLocalProvider _fundLocalProvider;

  TeamDetailsRepository(this._memberLocalProvider, this._fundLocalProvider);

  @override
  Future<DataState<int>> deleteMemberRatio(int id) {
    return safeDbCall(() => _memberLocalProvider.deleteMemberRatio(id));
  }

  @override
  Future<DataState<List<TeamMemberModel>>> fetchAllTeamMembers(int teamID) {
    return safeDbCall(() => _memberLocalProvider.fetchAllTeamMembers(teamID));
  }

  @override
  Future<DataState<TeamMemberModel>> insertTeamMember(TeamMemberParams params) {
    return safeDbCall(() => _memberLocalProvider.insertTeamMember(params));
  }

  @override
  Future<DataState<TeamMemberModel>> updateMemberRatio(
    TeamMemberParams params,
  ) {
    return safeDbCall(() => _memberLocalProvider.updateMemberRatio(params));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllMembers() {
    return safeDbCall(() => _memberLocalProvider.fetchAllMembers());
  }

  @override
  Future<DataState<int>> deleteFundRatio(int id) {
    return safeDbCall(() => _fundLocalProvider.deleteFundRatio(id));
  }

  @override
  Future<DataState<List<FundModel>>> fetchAllFunds() {
    return safeDbCall(() => _fundLocalProvider.fetchAllFunds());
  }

  @override
  Future<DataState<List<TeamFundModel>>> fetchAllTeamFunds(int teamID) {
    return safeDbCall(() => _fundLocalProvider.fetchAllTeamFunds(teamID));
  }

  @override
  Future<DataState<TeamFundModel>> insertTeamFund(TeamFundParams params) {
    return safeDbCall(() => _fundLocalProvider.insertTeamFund(params));
  }

  @override
  Future<DataState<TeamFundModel>> updateFundRatio(TeamFundParams params) {
    return safeDbCall(() => _fundLocalProvider.updateFundRatio(params));
  }
}
