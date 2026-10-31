import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_balance_source.dart';
import 'package:pay_pilot_plus/features/guests/repository/guest_repository.dart';

part 'guest_balance_state.dart';

class GuestBalanceCubit extends Cubit<GuestBalanceState> {
  final IGuestRepository _repository;
  GuestBalanceCubit(this._repository)
    : super(
        GuestBalanceState(
          balanceStatus: .initial,
          remainingStatus: .initial,
          registrationsStatus: .initial,
          remainingAmount: BigInt.zero,
          journals: List.empty(),
          registrations: List.empty(),
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

  Future<void> loadRegistrations(int userID) async {
    emit(state.copyWith(registrationsStatus: .loading));

    final dataState = await _repository.fetchRegistrations(userID);

    if (dataState.isSuccess) {
      final registrations = dataState.response!;
      // بعد از بارگذاری دوباره، فقط تیک ثبت‌نام‌هایی که هنوز هستند می‌ماند
      final ids = registrations.map((e) => e.id).toSet();

      emit(
        state.copyWith(
          registrationsStatus: .success,
          registrations: List.unmodifiable(registrations),
          selectedIDs: state.selectedIDs.intersection(ids),
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(registrationsStatus: .failure));
    }
  }

  void toggleSelection(int registrationID) {
    final ids = Set.of(state.selectedIDs);
    if (!ids.remove(registrationID)) ids.add(registrationID);
    emit(state.copyWith(selectedIDs: ids));
  }

  void clearSelection() => emit(state.copyWith(selectedIDs: const {}));
}
