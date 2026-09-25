import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/features/funds/repository/fund_repository.dart';

part 'fund_balance_state.dart';

class FundBalanceCubit extends Cubit<FundBalanceState> {
  final IFundRepository _repository;
  FundBalanceCubit(this._repository)
    : super(
        FundBalanceState(
          fundStatus: .initial,
          funds: List.empty(),
          remainingAmount: BigInt.zero,
          remainingStatus: .initial,
        ),
      );

  Future<void> loadFunds(int fundID) async {
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.fetchFund(fundID);

    if (dataState.isSuccess) {
      final allFunds = List<FundBalanceModel>.from(dataState.response!);
      emit(state.copyWith(fundStatus: .success, funds: allFunds));
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }

  Future<void> loadRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  }) async {
    emit(state.copyWith(remainingStatus: .loading));

    final dataState = await _repository.calculateFundsRemaining(
      openingBalance: openingBalance,
      fundBalances: fundBalances,
    );

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          remainingStatus: .success,
          remainingAmount: dataState.response!,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(remainingStatus: .failure));
    }
  }
}
