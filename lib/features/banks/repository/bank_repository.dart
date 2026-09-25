import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_local_provider.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_balance_source.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_source.dart';

abstract class IBankRepository
    implements
        IBankSource<
          DataState<BankModel>,
          DataState<int>,
          DataState<List<BankModel>>
        >,
        IBankBalanceSource<
          DataState<List<JournalLineModel>>,
          DataState<BigInt>
        > {}

class BankRepository extends BaseRepository implements IBankRepository {
  final IBankLocalProvider _bankLocalProvider;
  final IBankBalanceLocalProvider _balanceLocalProvider;

  BankRepository(this._bankLocalProvider, this._balanceLocalProvider);

  @override
  Future<DataState<int>> archiveBank(int id) {
    return safeDbCall(() => _bankLocalProvider.archiveBank(id));
  }

  @override
  Future<DataState<List<BankModel>>> fetchAllBanks() {
    return safeDbCall(() => _bankLocalProvider.fetchAllBanks());
  }

  @override
  Future<DataState<BankModel>> insertBank(BankParams params) {
    return safeDbCall(() => _bankLocalProvider.insertBank(params));
  }

  @override
  Future<DataState<BankModel>> updateBank(BankParams params) {
    return safeDbCall(() => _bankLocalProvider.updateBank(params));
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
  Future<DataState<List<JournalLineModel>>> fetchBankBalance(
    int bankAccountID,
  ) {
    return safeDbCall(
      () => _balanceLocalProvider.fetchBankBalance(bankAccountID),
    );
  }
}
