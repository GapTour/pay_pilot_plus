import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/features/members/repository/member_repository.dart';

part 'member_balance_state.dart';

class MemberBalanceCubit extends Cubit<MemberBalanceState> {
  final IMemberRepository _repository;
  MemberBalanceCubit(this._repository)
    : super(
        MemberBalanceState(
          balanceStatus: .initial,
          remainingStatus: .initial,
          remainingAmount: BigInt.zero,
          journals: List.empty(),
        ),
      );

  Future<void> loadBalanceInfo(int memberAccountID) async {
    emit(state.copyWith(balanceStatus: .loading));

    final dataState = await _repository.fetchMemberBalance(memberAccountID);

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
