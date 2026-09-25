import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';

abstract class IFundBalanceSource<TBigInt, TFund> {
  Future<TFund> fetchFund(int fundID);
  Future<TBigInt> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  });
}
