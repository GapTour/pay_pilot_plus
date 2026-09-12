part of 'event_registrations_cubit.dart';

enum RegistrationFetchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RegistrationFetchStatus.initial;
  bool get isLoading => this == RegistrationFetchStatus.loading;
  bool get isSuccess => this == RegistrationFetchStatus.success;
  bool get isFailure => this == RegistrationFetchStatus.failure;
}

enum RegistrationModificationStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RegistrationModificationStatus.initial;
  bool get isLoading => this == RegistrationModificationStatus.loading;
  bool get isSuccess => this == RegistrationModificationStatus.success;
  bool get isFailure => this == RegistrationModificationStatus.failure;
}

enum AbsentCheckboxStatus {
  initial,
  failure,
  changing;

  bool get isInitial => this == AbsentCheckboxStatus.initial;
  bool get isChanging => this == AbsentCheckboxStatus.changing;
  bool get isFailure => this == AbsentCheckboxStatus.failure;
}

class EventRegistrationsState extends Equatable {
  final RegistrationFetchStatus registrationFetchStatus;
  final RegistrationModificationStatus registrationModificationStatus;
  final AbsentCheckboxStatus absentCheckboxStatus;
  final List<EventRegistrationModel> registrations;
  final List<EventRegistrationModel> allRegistrations;
  final List<int> addedUsersID;
  const EventRegistrationsState({
    required this.registrationFetchStatus,
    required this.registrationModificationStatus,
    required this.absentCheckboxStatus,
    required this.registrations,
    required this.allRegistrations,
    required this.addedUsersID,
  });

  @override
  List<Object> get props {
    return [
      registrationFetchStatus,
      registrationModificationStatus,
      absentCheckboxStatus,
      registrations,
      allRegistrations,
      addedUsersID,
    ];
  }

  EventRegistrationsState copyWith({
    RegistrationFetchStatus? registrationFetchStatus,
    RegistrationModificationStatus? registrationModificationStatus,
    AbsentCheckboxStatus? absentCheckboxStatus,
    List<EventRegistrationModel>? registrations,
    List<EventRegistrationModel>? allRegistrations,
    List<int>? addedUsersID,
  }) {
    return EventRegistrationsState(
      registrationFetchStatus:
          registrationFetchStatus ?? this.registrationFetchStatus,
      registrationModificationStatus:
          registrationModificationStatus ?? this.registrationModificationStatus,
      absentCheckboxStatus: absentCheckboxStatus ?? this.absentCheckboxStatus,
      registrations: registrations ?? this.registrations,
      allRegistrations: allRegistrations ?? this.allRegistrations,
      addedUsersID: addedUsersID ?? this.addedUsersID,
    );
  }
}
