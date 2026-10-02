import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/database/daos/member_allocations/member_allocations_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_member_ratios_source.dart';

abstract class IEventMemberRatiosLocalProvider
    implements
        IEventMemberRatiosSource<List<TeamMemberModel>, TeamMemberModel, int> {}

class EventMemberRatiosLocalProvider extends BaseRepository
    implements IEventMemberRatiosLocalProvider {
  final MemberAllocationsDao _partnerSharesDao;

  EventMemberRatiosLocalProvider(this._partnerSharesDao);

  @override
  Future<int> deleteMemberRatio(int id) async {
    return await _partnerSharesDao.deleteMemberRatio(id);
  }

  @override
  Future<List<TeamMemberModel>> fetchAllMemberRatios(int eventID) async {
    final rawMembersRatio = await _partnerSharesDao.fetchAllMemberRatios(
      eventID,
    );

    return rawMembersRatio.map((row) {
      return TeamMemberModel(
        id: row.memberAllocation.id,
        sharePercentage: row.memberAllocation.sharePercentage,
        teamInfo: (id: 0, name: ''),
        userInfo: (id: row.user.id, name: row.user.name),
      );
    }).toList();
  }

  @override
  Future<TeamMemberModel> insertMemberRatio(
    MemberAllocationParams params,
  ) async {
    final shareID = await _partnerSharesDao.insertMemberRatio(params);

    return TeamMemberModel(
      id: shareID,
      sharePercentage: params.usersInfo.first.ratio,
      teamInfo: (id: 0, name: ''),
      userInfo: (
        id: params.usersInfo.first.id,
        name: params.usersInfo.first.name,
      ),
    );
  }

  @override
  Future<TeamMemberModel> updateMemberRatio(
    MemberAllocationParams params,
  ) async {
    await _partnerSharesDao.updateMemberRatio(params);

    return TeamMemberModel(
      id: params.id!,
      sharePercentage: params.usersInfo.first.ratio,
      teamInfo: (id: 0, name: ''),
      userInfo: (
        id: params.usersInfo.first.id,
        name: params.usersInfo.first.name,
      ),
    );
  }
}
