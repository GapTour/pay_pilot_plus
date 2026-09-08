import 'package:pay_pilot_plus/core/data/params/user_params.dart';

abstract class IHostSource<THost, TInt, TList> {
  Future<THost> insertHost(UserParams params);
  Future<TInt> archiveHost(int id);
  Future<TList> fetchAllHosts();
  Future<THost> updateHost(UserParams params);
}
