import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_local_provider.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_source.dart';

abstract class IBankRepository
    implements
        IBankSource<
          DataState<BankModel>,
          DataState<int>,
          DataState<List<BankModel>>
        > {}

class BankRepository extends BaseRepository implements IBankRepository {
  final IBankLocalProvider _localProvider;

  BankRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveBank(int id) {
    return safeDbCall(() => _localProvider.archiveBank(id));
  }

  @override
  Future<DataState<List<BankModel>>> fetchAllBanks() {
    return safeDbCall(() => _localProvider.fetchAllBanks());
  }

  @override
  Future<DataState<BankModel>> insertBank(BankParams params) {
    return safeDbCall(() => _localProvider.insertBank(params));
  }

  @override
  Future<DataState<BankModel>> updateBank(BankParams params) {
    return safeDbCall(() => _localProvider.updateBank(params));
  }
}
