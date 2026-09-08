import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/teams/data/providers/team_local_provider.dart';
import 'package:pay_pilot_plus/features/teams/data/sources/i_team_source.dart';

abstract class ITeamRepository
    implements
        ITeamSource<
          DataState<TeamModel>,
          DataState<int>,
          DataState<List<TeamModel>>
        > {}

class TeamRepository extends BaseRepository implements ITeamRepository {
  final ITeamLocalProvider _localProvider;

  TeamRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveTeam(int id) {
    return safeDbCall(() => _localProvider.archiveTeam(id));
  }

  @override
  Future<DataState<List<TeamModel>>> fetchAllTeams() {
    return safeDbCall(() => _localProvider.fetchAllTeams());
  }

  @override
  Future<DataState<TeamModel>> insertTeam(TeamParams params) {
    return safeDbCall(() => _localProvider.insertTeam(params));
  }

  @override
  Future<DataState<TeamModel>> updateTeam(TeamParams params) {
    return safeDbCall(() => _localProvider.updateTeam(params));
  }
}
