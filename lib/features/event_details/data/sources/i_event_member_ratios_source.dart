import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';

abstract class IEventMemberRatiosSource<TList, TRatio, TInt> {
  Future<TRatio> insertMemberRatio(MemberAllocationParams params);
  Future<TInt> deleteMemberRatio(int id);
  Future<TList> fetchAllMemberRatios(int eventID);
  Future<TRatio> updateMemberRatio(MemberAllocationParams params);
}
