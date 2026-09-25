import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/data/sources/i_host_balance_source.dart';
import 'package:pay_pilot_plus/features/hosts/data/sources/i_host_source.dart';

abstract class IHostRepository
    implements
        IHostSource<
          DataState<UserModel>,
          DataState<int>,
          DataState<List<UserModel>>
        >,
        IHostBalanceSource<
          DataState<List<JournalLineModel>>,
          DataState<BigInt>
        > {}

class HostRepository extends BaseRepository implements IHostRepository {
  final IHostLocalProvider _hostLocalProvider;
  final IHostBalanceLocalProvider _balanceLocalProvider;

  HostRepository(this._hostLocalProvider, this._balanceLocalProvider);

  @override
  Future<DataState<int>> archiveHost(int id) {
    return safeDbCall(() => _hostLocalProvider.archiveHost(id));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllHosts() {
    return safeDbCall(() => _hostLocalProvider.fetchAllHosts());
  }

  @override
  Future<DataState<UserModel>> insertHost(UserParams params) {
    return safeDbCall(() => _hostLocalProvider.insertHost(params));
  }

  @override
  Future<DataState<UserModel>> updateHost(UserParams params) {
    return safeDbCall(() => _hostLocalProvider.updateHost(params));
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
  Future<DataState<List<JournalLineModel>>> fetchHostBalance(
    int hostAccountID,
  ) {
    return safeDbCall(
      () => _balanceLocalProvider.fetchHostBalance(hostAccountID),
    );
  }
}
