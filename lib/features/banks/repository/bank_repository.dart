import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_balance_params.dart';
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
          DataState<BigInt>,
          DataState<
            List<({FundModel fund, List<FundBalanceModel> fundBalances})>
          >,
          DataState<JournalLineModel?>,
          DataState<List<UserModel>>,
          DataState<List<FundModel>>,
          DataState<List<EventModel>>
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

  @override
  Future<DataState<BigInt>> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  }) {
    return safeDbCall(
      () => _balanceLocalProvider.calculateFundsRemaining(
        openingBalance: openingBalance,
        fundBalances: fundBalances,
      ),
    );
  }

  @override
  Future<
    DataState<List<({FundModel fund, List<FundBalanceModel> fundBalances})>>
  >
  fetchAllFundsBalance() {
    return safeDbCall(() => _balanceLocalProvider.fetchAllFundsBalance());
  }

  @override
  Future<DataState<JournalLineModel?>> payTo(BankBalanceParams params) {
    return safeDbCall(() => _balanceLocalProvider.payTo(params));
  }

  @override
  Future<DataState<JournalLineModel?>> receiveFrom(BankBalanceParams params) {
    return safeDbCall(() => _balanceLocalProvider.receiveFrom(params));
  }

  @override
  Future<DataState<List<FundModel>>> fetchAllFunds() {
    return safeDbCall(() => _balanceLocalProvider.fetchAllFunds());
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllUsers() {
    return safeDbCall(() => _balanceLocalProvider.fetchAllUsers());
  }

  @override
  Future<DataState<List<EventModel>>> fetchAllEvents() {
    return safeDbCall(() => _balanceLocalProvider.fetchAllEvents());
  }
}
