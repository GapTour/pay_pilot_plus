import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/features/guests/repository/guest_repository.dart';

part 'guests_state.dart';

class GuestsCubit extends Cubit<GuestsState> {
  final IGuestRepository _repository;
  GuestsCubit(this._repository)
    : super(
        GuestsState(
          guestsStatus: GuestsStatus.initial,
          guests: [],
          allGuests: [],
        ),
      );

  void loadGuests() async {
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.fetchAllGuests();

    if (dataState.isSuccess) {
      final allGuests = dataState.response!;

      allGuests.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(
        state.copyWith(
          guestsStatus: GuestsStatus.success,
          guests: allGuests,
          allGuests: allGuests,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void addGuest(UserParams params) async {
    final allGuests = state.allGuests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.insertGuest(params);

    if (dataState.isSuccess) {
      final newGuest = dataState.response!;

      allGuests
        ..add(newGuest)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          guestsStatus: GuestsStatus.success,
          allGuests: allGuests,
          guests: allGuests,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void updateGuest(UserParams params) async {
    final allGuests = state.allGuests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.updateGuest(params);

    if (dataState.isSuccess) {
      final newGuest = dataState.response!;

      allGuests
        ..removeWhere((element) => element.userID == newGuest.userID)
        ..add(newGuest)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          guestsStatus: GuestsStatus.success,
          allGuests: allGuests,
          guests: allGuests,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void deleteGuest(int guestID) async {
    final allGuests = state.allGuests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.archiveGuest(guestID);

    if (dataState.isSuccess) {
      allGuests.removeWhere((element) => element.userID == guestID);

      emit(
        state.copyWith(
          guestsStatus: GuestsStatus.success,
          allGuests: allGuests,
          guests: allGuests,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void searchGuest(String query) {
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(
          guestsStatus: GuestsStatus.success,
          guests: state.allGuests,
        ),
      );
      return;
    }

    final filteredMembers = state.allGuests.where((g) {
      return g.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(
        guestsStatus: GuestsStatus.success,
        guests: filteredMembers,
      ),
    );
  }
}
