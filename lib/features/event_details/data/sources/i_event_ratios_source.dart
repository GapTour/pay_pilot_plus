import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';

abstract class IEventRatiosSource<TList, TRatio, TInt> {
  Future<TRatio> insertRatio(EventPartnerShareParams params);
  Future<TInt> deleteRatio(int id);
  Future<TList> fetchAllRatios(int eventID);
  Future<TRatio> updateRatio(EventPartnerShareParams params);
}
