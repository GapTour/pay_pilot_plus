part of 'event_modification_bloc.dart';

enum ConfigurationsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == .initial;
  bool get isLoading => this == .loading && this == .initial;
  bool get isSuccess => this == .success;
  bool get isFailure => this == .failure;
}

class EventModificationState extends Equatable {
  final CloseEventStatus closeEventStatus;
  final OpenEventStatus openEventStatus;
  final ConfigurationsStatus configurationsStatus;
  final List<int> registeredGuests;
  final List<UserModel> allUsers;
  final EventModel? openedEvent;
  const EventModificationState({
    required this.closeEventStatus,
    required this.openEventStatus,
    required this.configurationsStatus,
    required this.registeredGuests,
    required this.allUsers,
    required this.openedEvent,
  });

  @override
  List<Object?> get props {
    return [
      closeEventStatus,
      openEventStatus,
      configurationsStatus,
      registeredGuests,
      allUsers,
      openedEvent,
    ];
  }

  EventModificationState copyWith({
    CloseEventStatus? closeEventStatus,
    OpenEventStatus? openEventStatus,
    ConfigurationsStatus? configurationsStatus,
    List<int>? registeredGuests,
    List<UserModel>? allUsers,
    EventModel? openedEvent,
  }) {
    return EventModificationState(
      closeEventStatus: closeEventStatus ?? this.closeEventStatus,
      openEventStatus: openEventStatus ?? this.openEventStatus,
      configurationsStatus: configurationsStatus ?? this.configurationsStatus,
      registeredGuests: registeredGuests ?? this.registeredGuests,
      allUsers: allUsers ?? this.allUsers,
      openedEvent: openedEvent ?? this.openedEvent,
    );
  }
}
