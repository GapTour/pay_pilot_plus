import 'package:pay_pilot_plus/core/data/params/fund_params.dart';

abstract class IFundSource<TFund, TInt, TList> {
  Future<TFund> insertFund(FundParams params);
  Future<TInt> archiveFund(int id);
  Future<TList> fetchAllFunds();
  Future<TFund> updateFund(FundParams params);
}
