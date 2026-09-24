import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'team_members_dao.g.dart';

@DriftAccessor(tables: [TeamMembers, Teams, Users, DetailedAccounts])
class TeamMembersDao extends DatabaseAccessor<AppDatabase>
    with _$TeamMembersDaoMixin {
  TeamMembersDao(super.db);

  Future<int> insertTeamMember(TeamMemberParams params) async {
    return await transaction(() async {
      return await db
          .into(teamMembers)
          .insert(
            TeamMembersCompanion(
              sharePercentage: Value(params.ratio),
              teamID: Value(params.teamInfo.id),
              userID: Value(params.userInfo.id),
            ),
          );
    });
  }

  Future<List<({TeamMember member, User user, int userDetailedAccountID})>>
  fetchAllTeamMembers(int teamID) async {
    final query =
        (select(teamMembers)..where((tbl) => tbl.teamID.equals(teamID))).join([
          innerJoin(users, users.id.equalsExp(teamMembers.userID)),
          innerJoin(
            detailedAccounts,
            detailedAccounts.userID.equalsExp(teamMembers.userID),
          ),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final teamMember = row.readTable(teamMembers);
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (
        member: teamMember,
        user: user,
        userDetailedAccountID: account.id,
      );
    }).toList();
  }

  Future<int> updateMemberRatio(TeamMemberParams params) async {
    return await transaction(() async {
      return await (update(teamMembers)
            ..where((tbl) => tbl.id.equals(params.id!)))
          .write(TeamMembersCompanion(sharePercentage: Value(params.ratio)));
    });
  }

  Future<int> deleteMemberRatio(int id) async {
    return await transaction(() async {
      return await (delete(
        teamMembers,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }
}
