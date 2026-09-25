import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/sources/i_member_balance_source.dart';
import 'package:pay_pilot_plus/features/members/data/sources/i_member_source.dart';

abstract class IMemberRepository
    implements
        IMemberSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        >,
        IMemberBalanceSource<
          DataState<List<JournalLineModel>>,
          DataState<BigInt>
        > {}

class MemberRepository extends BaseRepository implements IMemberRepository {
  final IMemberLocalProvider _memberLocalProvider;
  final IMemberBalanceLocalProvider _balanceLocalProvider;

  MemberRepository(this._memberLocalProvider, this._balanceLocalProvider);

  @override
  Future<DataState<int>> archiveMember(int id) {
    return safeDbCall(() => _memberLocalProvider.archiveMember(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllMembers() {
    return safeDbCall(() => _memberLocalProvider.fetchAllMembers());
  }

  @override
  Future<DataState<UserModel>> insertMember(UserParams params) {
    return safeDbCall(() => _memberLocalProvider.insertMember(params));
  }

  @override
  Future<DataState<UserModel>> updateMember(UserParams params) {
    return safeDbCall(() => _memberLocalProvider.updateMember(params));
  }

  @override
  Future<DataState<BigInt>> calculateRemaining(
    List<JournalLineModel> journalLines,
  ) {
    return safeDbCall(
      () => _balanceLocalProvider.calculateRemaining(journalLines),
    );
  }

  @override
  Future<DataState<List<JournalLineModel>>> fetchMemberBalance(
    int memberAccountID,
  ) {
    return safeDbCall(
      () => _balanceLocalProvider.fetchMemberBalance(memberAccountID),
    );
  }
}
