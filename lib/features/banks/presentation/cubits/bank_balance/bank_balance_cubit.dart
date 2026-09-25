import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/features/banks/repository/bank_repository.dart';

part 'bank_balance_state.dart';

class BankBalanceCubit extends Cubit<BankBalanceState> {
  final IBankRepository _repository;
  BankBalanceCubit(this._repository)
    : super(
        BankBalanceState(
          balanceStatus: .initial,
          remainingStatus: .initial,
          remainingAmount: BigInt.zero,
          fundStatus: .initial,
          funds: List.empty(),
          journals: List.empty(),
        ),
      );

  Future<void> loadBalanceInfo(int bankAccountID) async {
    emit(state.copyWith(balanceStatus: .loading));

    final dataState = await _repository.fetchBankBalance(bankAccountID);

    if (dataState.isSuccess) {
      final allJournals = List<JournalLineModel>.from(dataState.response!);

      emit(state.copyWith(balanceStatus: .success, journals: allJournals));
    }

    if (dataState.isFailed) {
      emit(state.copyWith(balanceStatus: .failure));
    }
  }

  Future<void> loadRemaining(List<JournalLineModel> allJournals) async {
    emit(state.copyWith(remainingStatus: .loading));

    final dataState = await _repository.calculateRemaining(allJournals);

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          remainingStatus: .success,
          remainingAmount: dataState.response,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(remainingStatus: .failure));
    }
  }

  Future<void> loadFunds() async {
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.fetchAllFunds();

    if (dataState.isSuccess) {
      final funds = <({BigInt amount, String title})>[];

      for (var f in dataState.response!) {
        final calculatedDataState = await _repository.calculateFundsRemaining(
          openingBalance: f.fund.openingBalance,
          fundBalances: f.fundBalances,
        );

        if (calculatedDataState.isSuccess) {
          funds.add((
            amount: calculatedDataState.response!,
            title: f.fund.title,
          ));
        }
      }

      emit(state.copyWith(fundStatus: .success, funds: funds));
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }
}
