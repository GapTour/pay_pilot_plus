import 'package:pay_pilot_plus/core/data/params/user_params.dart';

abstract class IMemberSource<TMember, TInt, TList> {
  Future<TMember> insertMember(UserParams params);
  Future<TInt> archiveMember(int id);
  Future<TList> fetchAllMembers();
  Future<TMember> updateMember(UserParams params);
}
