part of 'event_modification_bloc.dart';

sealed class EventModificationEvent extends Equatable {
  const EventModificationEvent();

  @override
  List<Object> get props => [];
}

class CloseEvent extends EventModificationEvent {
  final CloseEventParams params;

  const new(this.params);
}

class InitConfigurations extends EventModificationEvent {
  final EventModel openedEvent;

  const new(this.openedEvent);
}

class OpenEvent extends EventModificationEvent {
  final int eventID;

  const new(this.eventID);
}
