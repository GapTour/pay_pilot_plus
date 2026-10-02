import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_registrations_state.dart';

class EventRegistrationsCubit extends Cubit<EventRegistrationsState> {
  final IEventDetailsRepository _repository;

  EventRegistrationsCubit(this._repository)
    : super(
        EventRegistrationsState(
          allRegistrations: List.empty(),
          registrations: List.empty(),
          addedUsersID: List.empty(),
          registrationFetchStatus: .initial,
          registrationModificationStatus: .initial,
          absentCheckboxStatus: .initial,
        ),
      );

  Future<void> initRegistrations(int eventID) async {
    emit(state.copyWith(registrationFetchStatus: .loading));

    final dataState = await _repository.fetchAllRegistrations(eventID);

    if (dataState.isSuccess) {
      final registrations = List<EventRegistrationModel>.from(
        dataState.response!,
      );
      final addedUsers = registrations.map((e) => e.user.id).toList();

      emit(
        state.copyWith(
          allRegistrations: registrations,
          registrations: registrations,
          addedUsersID: addedUsers,
          registrationFetchStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(registrationFetchStatus: .failure));
    }
  }

  void _changeModificationToInit() {
    emit(state.copyWith(registrationModificationStatus: .initial));
  }

  Future<void> registerGuest(EventRegistrationParams params) async {
    emit(state.copyWith(registrationModificationStatus: .loading));

    final dataState = await _repository.registerGuests(params);

    if (dataState.isSuccess) {
      final allRegistrations = List<EventRegistrationModel>.from(
        dataState.response!,
      );

      final addedUsers = allRegistrations.map((e) => e.user.id).toList();

      emit(
        state.copyWith(
          allRegistrations: allRegistrations,
          registrations: allRegistrations,
          addedUsersID: addedUsers,
          registrationModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(registrationModificationStatus: .failure));
    }
  }

  Future<void> registerMember(EventRegistrationParams params) async {
    emit(state.copyWith(registrationModificationStatus: .loading));

    final dataState = await _repository.registerMembers(params);

    if (dataState.isSuccess) {
      final allRegistrations = List<EventRegistrationModel>.from(
        dataState.response!,
      );

      final addedUsers = allRegistrations.map((e) => e.user.id).toList();

      emit(
        state.copyWith(
          allRegistrations: allRegistrations,
          registrations: allRegistrations,
          addedUsersID: addedUsers,
          registrationModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(registrationModificationStatus: .failure));
    }
  }

  Future<void> deleteRegistration(DeleteRegistrationParams params) async {
    emit(state.copyWith(registrationModificationStatus: .loading));

    final dataState = await _repository.deleteRegistration(params);

    if (dataState.isSuccess) {
      final allRegistrations = List<EventRegistrationModel>.from(
        state.allRegistrations,
      )..removeWhere((e) => e.id == params.eventRegistrationID);

      final addedUsers = allRegistrations.map((e) => e.user.id).toList();

      emit(
        state.copyWith(
          allRegistrations: allRegistrations,
          registrations: allRegistrations,
          addedUsersID: addedUsers,
          registrationModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(registrationModificationStatus: .failure));
    }
  }

  Future<void> changeAbsentStatus(int id, bool isAbsent) async {
    emit(state.copyWith(absentCheckboxStatus: .changing));

    final index = state.registrations.indexWhere((e) => e.id == id);
    final notUpdatedItem = state.registrations.firstWhere((e) => e.id == id);
    final updatedItem = notUpdatedItem.copyWith(wasAbsent: isAbsent);

    final updatedList = List<EventRegistrationModel>.from(state.registrations)
      ..removeAt(index)
      ..insert(index, updatedItem);

    final updatedAllList =
        List<EventRegistrationModel>.from(state.allRegistrations)
          ..removeWhere((e) => e.id == id)
          ..add(updatedItem);

    updatedAllList.sort((a, b) => a.counter.compareTo(b.counter));

    emit(
      state.copyWith(
        allRegistrations: updatedAllList,
        registrations: updatedList,
        absentCheckboxStatus: .initial,
      ),
    );

    final dataState = await _repository.changeAbsentStatus(id, isAbsent);

    if (dataState.isFailed) {
      emit(
        state.copyWith(
          allRegistrations: state.allRegistrations,
          registrations: state.registrations,
          absentCheckboxStatus: .failure,
        ),
      );
    }
  }

  void searchItem(String query) {
    emit(state.copyWith(registrationFetchStatus: .loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(
          registrationFetchStatus: .success,
          registrations: state.allRegistrations,
        ),
      );
      return;
    }

    final filteredItems = state.allRegistrations.where((bank) {
      return bank.user.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(
        registrationFetchStatus: .success,
        registrations: filteredItems,
      ),
    );
  }
}
