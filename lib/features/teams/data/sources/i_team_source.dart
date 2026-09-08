import 'package:pay_pilot_plus/core/data/params/team_params.dart';

abstract class ITeamSource<TTeam, TInt, TList> {
  Future<TTeam> insertTeam(TeamParams params);
  Future<TInt> archiveTeam(int id);
  Future<TList> fetchAllTeams();
  Future<TTeam> updateTeam(TeamParams params);
}
