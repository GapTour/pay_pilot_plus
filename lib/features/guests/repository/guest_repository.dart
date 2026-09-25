import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_balance_source.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_source.dart';

abstract class IGuestRepository
    implements
        IGuestSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        >,
        IGuestBalanceSource<
          DataState<List<JournalLineModel>>,
          DataState<BigInt>
        > {}

class GuestRepository extends BaseRepository implements IGuestRepository {
  final IGuestLocalProvider _guestLocalProvider;
  final IGuestBalanceLocalProvider _balanceLocalProvider;

  GuestRepository(this._guestLocalProvider, this._balanceLocalProvider);

  @override
  Future<DataState<int>> archiveGuest(int id) {
    return safeDbCall(() => _guestLocalProvider.archiveGuest(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllGuests() {
    return safeDbCall(() => _guestLocalProvider.fetchAllGuests());
  }

  @override
  Future<DataState<UserModel>> insertGuest(UserParams params) {
    return safeDbCall(() => _guestLocalProvider.insertGuest(params));
  }

  @override
  Future<DataState<UserModel>> updateGuest(UserParams params) {
    return safeDbCall(() => _guestLocalProvider.updateGuest(params));
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
