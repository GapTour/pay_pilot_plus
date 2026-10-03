import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_balance_params.dart';
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
          allFunds: List.empty(),
          allUsers: List.empty(),
          allEvents: List.empty(),
        ),
      );

  Future<void> loadBalanceInfo(int bankAccountID) async {
    emit(state.copyWith(balanceStatus: .loading));

    final dataState = await _repository.fetchBankBalance(bankAccountID);

    if (dataState.isSuccess) {
      final usersResponse = await _fetchAllUsers();
      final fundsResponse = await _fetchAllFunds();
      final eventsResponse = await _fetchAllEvents();
      final allJournals = List<JournalLineModel>.from(dataState.response!);

      emit(
        state.copyWith(
          balanceStatus: .success,
          allUsers: List.from(usersResponse ?? []),
          allFunds: List.from(fundsResponse ?? []),
          allEvents: List.from(eventsResponse ?? []),
          journals: allJournals,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(balanceStatus: .failure));
    }
  }

  Future<List<UserModel>?> _fetchAllUsers() async {
    final dataSate = await _repository.fetchAllUsers();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
  }

  Future<List<FundModel>?> _fetchAllFunds() async {
    final dataSate = await _repository.fetchAllFunds();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
  }

  Future<List<EventModel>?> _fetchAllEvents() async {
    final dataSate = await _repository.fetchAllEvents();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
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

    final dataState = await _repository.fetchAllFundsBalance();

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

  Future<void> payTo(BankBalanceParams params) async {
    emit(state.copyWith(balanceStatus: .loading, remainingStatus: .loading));

    final dataState = await _repository.payTo(params);

    if (dataState.isSuccess) {
      final addedJournal = dataState.response!;
      final allJournals = List<JournalLineModel>.from(state.journals)
        ..add(addedJournal);

      final remainingAmount = state.remainingAmount - addedJournal.credit;

      emit(
        state.copyWith(
          remainingStatus: .success,
          balanceStatus: .success,
          journals: allJournals,
          remainingAmount: remainingAmount,
        ),
      );

      if (params.fundInfo != null) loadFunds();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(balanceStatus: .success, remainingStatus: .success));
    }
  }

  Future<void> receiveFrom(BankBalanceParams params) async {
    emit(state.copyWith(balanceStatus: .loading, remainingStatus: .loading));

    final dataState = await _repository.receiveFrom(params);

    if (dataState.isSuccess) {
      final addedJournal = dataState.response!;
      final allJournals = List<JournalLineModel>.from(state.journals)
        ..add(addedJournal);

      final remainingAmount = state.remainingAmount + addedJournal.debit;

      emit(
        state.copyWith(
          remainingStatus: .success,
          balanceStatus: .success,
          journals: allJournals,
          remainingAmount: remainingAmount,
        ),
      );

      if (params.fundInfo != null) loadFunds();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(balanceStatus: .success, remainingStatus: .success));
    }
  }
}
