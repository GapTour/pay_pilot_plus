import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/team_members/data/providers/team_member_local_provider.dart';
import 'package:pay_pilot_plus/features/team_members/data/sources/i_team_member_source.dart';

abstract class ITeamMemberRepository
    implements
        ITeamMemberSource<
          DataState<TeamMemberModel>,
          DataState<int>,
          DataState<List<TeamMemberModel>>,
          DataState<List<UserModel>>
        > {}

class TeamMemberRepository extends BaseRepository
    implements ITeamMemberRepository {
  final ITeamMemberLocalProvider _localProvider;

  TeamMemberRepository(this._localProvider);

  @override
  Future<DataState<int>> deleteRatio(int id) {
    return safeDbCall(() => _localProvider.deleteRatio(id));
  }

  @override
  Future<DataState<List<TeamMemberModel>>> fetchAllTeamMembers(int teamID) {
    return safeDbCall(() => _localProvider.fetchAllTeamMembers(teamID));
  }

  @override
  Future<DataState<TeamMemberModel>> insertTeamMember(TeamMemberParams params) {
    return safeDbCall(() => _localProvider.insertTeamMember(params));
  }

  @override
  Future<DataState<TeamMemberModel>> updateRatio(TeamMemberParams params) {
    return safeDbCall(() => _localProvider.updateRatio(params));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllMembers() {
    return safeDbCall(() => _localProvider.fetchAllMembers());
  }
}
