import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/data/sources/i_host_source.dart';

abstract class IHostRepository
    implements
        IHostSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        > {}

class HostRepository extends BaseRepository implements IHostRepository {
  final IHostLocalProvider _localProvider;

  HostRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveHost(int id) {
    return safeDbCall(() => _localProvider.archiveHost(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllHosts() {
    return safeDbCall(() => _localProvider.fetchAllHosts());
  }

  @override
  Future<DataState<UserModel>> insertHost(UserParams params) {
    return safeDbCall(() => _localProvider.insertHost(params));
  }

  @override
  Future<DataState<UserModel>> updateHost(UserParams params) {
    return safeDbCall(() => _localProvider.updateHost(params));
  }
}
