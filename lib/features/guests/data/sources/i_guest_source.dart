import 'package:pay_pilot_plus/core/data/params/user_params.dart';

abstract class IGuestSource<TGuest, TInt, TList> {
  Future<TGuest> insertGuest(UserParams params);
  Future<TInt> archiveGuest(int id);
  Future<TList> fetchAllGuests();
  Future<TGuest> updateGuest(UserParams params);
}
