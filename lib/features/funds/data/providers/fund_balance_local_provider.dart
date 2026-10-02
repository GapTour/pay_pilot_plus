import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/calculate_sum_on_background_thread.dart';
import 'package:pay_pilot_plus/features/funds/data/sources/i_fund_balance_source.dart';

abstract class IFundBalanceLocalProvider
    implements IFundBalanceSource<BigInt, List<FundBalanceModel>> {}

class FundBalanceLocalProvider implements IFundBalanceLocalProvider {
  final FundBalancesDao _fundBalancesDao;

  FundBalanceLocalProvider(this._fundBalancesDao);

  @override
  Future<BigInt> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  }) async {
    final debitSets = fundBalances.map((e) => e.debit).toList();
    final debitAmounts = await calculateSumOnBackgroundThread(debitSets);

    final creditSets = fundBalances.map((e) => e.credit).toList();
    final creditAmounts = await calculateSumOnBackgroundThread(creditSets);

    return openingBalance + debitAmounts - creditAmounts;
  }

  @override
  Future<List<FundBalanceModel>> fetchFund(int fundID) async {
    final results = await _fundBalancesDao.fetchSpecificFundBalances(fundID);

    final balances = results.map((e) {
      return FundBalanceModel(
        id: e.id,
        title: '',
        debit: e.debit,
        credit: e.credit,
        date: e.date,
        memo: e.memo,
        series: e.series,
      );
    }).toList();

    return balances;
  }
}
