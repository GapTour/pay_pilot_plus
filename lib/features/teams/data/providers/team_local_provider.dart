import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_params.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/features/teams/data/sources/i_team_source.dart';

abstract class ITeamLocalProvider
    implements ITeamSource<TeamModel, int, List<TeamModel>> {}

class TeamLocalProvider implements ITeamLocalProvider {
  final TeamsDao _teamsDao;

  TeamLocalProvider(this._teamsDao);

  @override
  Future<int> archiveTeam(int id) async {
    return await _teamsDao.archiveTeam(id);
  }

  @override
  Future<List<TeamModel>> fetchAllTeams() async {
    final teams = await _teamsDao.fetchAllActiveTeams();

    return teams.map((e) {
      return TeamModel(
        id: e.id,
        title: e.title,
        description: e.description,
        isActive: e.isActive,
      );
    }).toList();
  }

  @override
  Future<TeamModel> insertTeam(TeamParams params) async {
    final teamID = await _teamsDao.insertTeam(params);

    return TeamModel(
      id: teamID,
      title: params.title,
      description: params.description,
      isActive: true,
    );
  }

  @override
  Future<TeamModel> updateTeam(TeamParams params) async {
    await _teamsDao.updateTeam(params);

    return TeamModel(
      id: params.id!,
      title: params.title,
      description: params.description,
      isActive: params.isActive,
    );
  }
}
