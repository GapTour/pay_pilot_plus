import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/features/team_members/data/sources/i_team_member_source.dart';

abstract class ITeamMemberLocalProvider
    implements
        ITeamMemberSource<
          TeamMemberModel,
          int,
          List<TeamMemberModel>,
          List<UserModel>
        > {}

class TeamMemberLocalProvider implements ITeamMemberLocalProvider {
  final TeamMembersDao _membersDao;
  final UsersDao _usersDao;

  TeamMemberLocalProvider(this._usersDao, this._membersDao);

  @override
  Future<int> deleteRatio(int id) async {
    return _membersDao.deleteRatio(id);
  }

  @override
  Future<List<TeamMemberModel>> fetchAllTeamMembers(int teamID) async {
    final result = await _membersDao.fetchAllTeamMembers(teamID);

    return result.map((e) {
      final teamMember = e.member;
      final user = e.user;

      return TeamMemberModel(
        id: teamMember.id,
        teamID: teamID,
        sharePercentage: teamMember.sharePercentage,
        userInfo: (id: user.id, name: user.name),
      );
    }).toList();
  }

  @override
  Future<TeamMemberModel> insertTeamMember(TeamMemberParams params) async {
    final memberID = await _membersDao.insertTeamMember(params);

    return TeamMemberModel(
      id: memberID,
      teamID: params.teamInfo.id,
      sharePercentage: params.ratio,
      userInfo: params.userInfo,
    );
  }

  @override
  Future<TeamMemberModel> updateRatio(TeamMemberParams params) async {
    final memberID = await _membersDao.updateRatio(params);

    return TeamMemberModel(
      id: memberID,
      teamID: params.teamInfo.id,
      sharePercentage: params.ratio,
      userInfo: params.userInfo,
    );
  }

  @override
  Future<List<UserModel>> fetchAllMembers() async {
    final result = await _usersDao.fetchAllStaffs();

    return result.map((e) {
      final user = e.user;
      final account = e.account;

      return UserModel(
        userID: user.id,
        detailedAccountID: account.id,
        accountCode: account.code,
        accountName: account.name,
        name: user.name,
        description: user.description,
        phoneNumber: user.phoneNumber,
        isActive: user.isActive,
        profileImage: user.profileImage,
        telegramID: user.telegramId,
        instagramID: user.instagramId,
        birthday: user.birthday,
        role: user.role,
      );
    }).toList();
  }
}
