import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';

abstract class ITeamMemberSource<TRatio, TInt, TList, TMembers> {
  Future<TRatio> insertTeamMember(TeamMemberParams params);
  Future<TInt> deleteRatio(int id);
  Future<TList> fetchAllTeamMembers(int teamID);
  Future<TMembers> fetchAllMembers();
  Future<TRatio> updateRatio(TeamMemberParams params);
}
