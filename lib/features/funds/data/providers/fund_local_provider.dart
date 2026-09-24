import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/features/funds/data/sources/i_fund_source.dart';

abstract class IFundLocalProvider
    implements IFundSource<FundModel, int, List<FundModel>> {}

class FundLocalProvider implements IFundLocalProvider {
  final FundsDao _fundsDao;

  FundLocalProvider(this._fundsDao);

  @override
  Future<int> archiveFund(int id) async {
    return await _fundsDao.archiveFund(id);
  }

  @override
  Future<List<FundModel>> fetchAllFunds() async {
    final funds = await _fundsDao.fetchAllActiveFunds();

    return funds.map((e) {
      return FundModel(
        id: e.id,
        title: e.title,
        openingBalance: e.openingBalance,
        isActive: e.isActive,
      );
    }).toList();
  }

  @override
  Future<FundModel> insertFund(FundParams params) async {
    final teamID = await _fundsDao.insertFund(params);

    return FundModel(
      id: teamID,
      title: params.title,
      openingBalance: params.openingBalance ?? BigInt.zero,
      isActive: true,
    );
  }

  @override
  Future<FundModel> updateFund(FundParams params) async {
    await _fundsDao.updateFund(params);

    return FundModel(
      id: params.id!,
      title: params.title,
      openingBalance: params.openingBalance ?? BigInt.zero,
      isActive: params.isActive,
    );
  }
}
