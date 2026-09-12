import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/core/database/daos/event_partner_shares/event_partner_shares_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_ratios_source.dart';

abstract class IEventRatiosLocalProvider
    implements
        IEventRatiosSource<List<TeamMemberModel>, TeamMemberModel, int> {}

class EventRatiosLocalProvider extends BaseRepository
    implements IEventRatiosLocalProvider {
  final EventPartnerSharesDao _partnerSharesDao;

  EventRatiosLocalProvider(this._partnerSharesDao);

  @override
  Future<int> deleteRatio(int id) async {
    return await _partnerSharesDao.deleteRatio(id);
  }

  @override
  Future<List<TeamMemberModel>> fetchAllRatios(int eventID) async {
    final rawMembersRatio = await _partnerSharesDao.fetchAllPartnerShares(
      eventID,
    );

    return rawMembersRatio.map((row) {
      return TeamMemberModel(
        id: row.partnerShare.id,
        sharePercentage: row.partnerShare.sharePercentage,
        teamInfo: (id: 0, name: ''),
        userInfo: (id: row.user.id, name: row.user.name),
      );
    }).toList();
  }

  @override
  Future<TeamMemberModel> insertRatio(EventPartnerShareParams params) async {
    final shareID = await _partnerSharesDao.insertPartnerShare(params);

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
  Future<TeamMemberModel> updateRatio(EventPartnerShareParams params) async {
    await _partnerSharesDao.updateRatio(params);

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
