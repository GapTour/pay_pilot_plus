import 'package:collection/collection.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/features/team_details/data/sources/i_team_member_source.dart';

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
  final JournalsDao _journalsDao;

  TeamMemberLocalProvider(this._usersDao, this._journalsDao, this._membersDao);

  @override
  Future<int> deleteMemberRatio(int id) async {
    return _membersDao.deleteMemberRatio(id);
  }

  @override
  Future<List<TeamMemberModel>> fetchAllTeamMembers(int teamID) async {
    final result = await _membersDao.fetchAllTeamMembers(teamID);

    return result.map((e) {
      final teamMember = e.member;
      final user = e.user;

      return TeamMemberModel(
        id: teamMember.id,
        teamInfo: (id: teamID, name: 'No Name'),
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
      teamInfo: params.teamInfo,
      sharePercentage: params.ratio,
      userInfo: params.userInfo,
    );
  }

  @override
  Future<TeamMemberModel> updateMemberRatio(TeamMemberParams params) async {
    final memberID = await _membersDao.updateMemberRatio(params);

    return TeamMemberModel(
      id: memberID,
      teamInfo: params.teamInfo,
      sharePercentage: params.ratio,
      userInfo: params.userInfo,
    );
  }

  @override
  Future<List<UserModel>> fetchAllMembers() async {
    final result = await _usersDao.fetchAllActiveStaffs();
    final openingLines = await _journalsDao.fetchAllOpeningJournals();

    return result.map((e) {
      final user = e.user;
      final account = e.account;
      final openingInfo = openingLines?.firstWhereOrNull((e) {
        return e.firstDetailedId == account.id && e.credit != BigInt.zero;
      });

      return UserModel(
        id: user.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        openingBalance: openingInfo?.credit ?? BigInt.zero,
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
