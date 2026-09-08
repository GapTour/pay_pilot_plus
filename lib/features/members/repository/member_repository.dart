import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/sources/i_member_source.dart';

abstract class IMemberRepository
    implements
        IMemberSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        > {}

class MemberRepository extends BaseRepository implements IMemberRepository {
  final IMemberLocalProvider _localProvider;

  MemberRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveMember(int id) {
    return safeDbCall(() => _localProvider.archiveMember(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllMembers() {
    return safeDbCall(() => _localProvider.fetchAllMembers());
  }

  @override
  Future<DataState<UserModel>> insertMember(UserParams params) {
    return safeDbCall(() => _localProvider.insertMember(params));
  }

  @override
  Future<DataState<UserModel>> updateMember(UserParams params) {
    return safeDbCall(() => _localProvider.updateMember(params));
  }
}
