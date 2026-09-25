import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/features/hosts/repository/host_repository.dart';

part 'host_balance_state.dart';

class HostBalanceCubit extends Cubit<HostBalanceState> {
  final IHostRepository _repository;
  HostBalanceCubit(this._repository)
    : super(
        HostBalanceState(
          balanceStatus: .initial,
          remainingStatus: .initial,
          remainingAmount: BigInt.zero,
          journals: List.empty(),
        ),
      );

  Future<void> loadBalanceInfo(int hostAccountID) async {
    emit(state.copyWith(balanceStatus: .loading));

    final dataState = await _repository.fetchHostBalance(hostAccountID);

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
}
