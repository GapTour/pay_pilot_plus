import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_allocations/fund_allocations_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_fund_ratios_source.dart';

abstract class IEventFundRatiosLocalProvider
    implements
        IEventFundRatiosSource<List<TeamFundModel>, TeamFundModel, int> {}

class EventFundRatiosLocalProvider extends BaseRepository
    implements IEventFundRatiosLocalProvider {
  final FundAllocationsDao _fundRatiosDao;

  EventFundRatiosLocalProvider(this._fundRatiosDao);

  @override
  Future<int> deleteFundRatio(int id) async {
    return await _fundRatiosDao.deleteFundRatio(id);
  }

  @override
  Future<List<TeamFundModel>> fetchAllFundRatios(int eventID) async {
    final rawMembersRatio = await _fundRatiosDao.fetchAllFundRatios(eventID);

    return rawMembersRatio.map((row) {
      return TeamFundModel(
        id: row.fundAllocation.id,
        sharePercentage: row.fundAllocation.sharePercentage,
        teamInfo: (id: 0, name: ''),
        fundInfo: (id: row.fund.id, name: row.fund.title),
      );
    }).toList();
  }

  @override
  Future<TeamFundModel> insertFundRatio(FundAllocationParams params) async {
    final shareID = await _fundRatiosDao.insertFundRatio(params);

    return TeamFundModel(
      id: shareID,
      sharePercentage: params.fundsInfo.first.ratio,
      teamInfo: (id: 0, name: ''),
      fundInfo: (
        id: params.fundsInfo.first.id,
        name: params.fundsInfo.first.name,
      ),
    );
  }

  @override
  Future<TeamFundModel> updateFundRatio(FundAllocationParams params) async {
    await _fundRatiosDao.updateFundRatio(params);

    return TeamFundModel(
      id: params.id!,
      sharePercentage: params.fundsInfo.first.ratio,
      teamInfo: (id: 0, name: ''),
      fundInfo: (
        id: params.fundsInfo.first.id,
        name: params.fundsInfo.first.name,
      ),
    );
  }
}
