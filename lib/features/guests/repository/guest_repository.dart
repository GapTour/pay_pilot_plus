import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_source.dart';

abstract class IGuestRepository
    implements
        IGuestSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        > {}

class GuestRepository extends BaseRepository implements IGuestRepository {
  final IGuestLocalProvider _localProvider;

  GuestRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveGuest(int id) {
    return safeDbCall(() => _localProvider.archiveGuest(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllGuests() {
    return safeDbCall(() => _localProvider.fetchAllGuests());
  }

  @override
  Future<DataState<UserModel>> insertGuest(UserParams params) {
    return safeDbCall(() => _localProvider.insertGuest(params));
  }

  @override
  Future<DataState<UserModel>> updateGuest(UserParams params) {
    return safeDbCall(() => _localProvider.updateGuest(params));
  }
}
