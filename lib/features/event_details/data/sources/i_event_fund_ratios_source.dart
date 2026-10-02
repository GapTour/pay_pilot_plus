import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';

abstract class IEventFundRatiosSource<TList, TAllocation, TInt> {
  Future<TAllocation> insertFundRatio(FundAllocationParams params);
  Future<TInt> deleteFundRatio(int id);
  Future<TList> fetchAllFundRatios(int eventID);
  Future<TAllocation> updateFundRatio(FundAllocationParams params);
}
