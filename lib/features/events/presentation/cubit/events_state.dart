part of 'events_cubit.dart';

class EventsState extends Equatable {
  final EventsStatus eventsStatus;
  final List<EventModel> events;
  final List<EventModel> allEvents;
  final List<TeamModel> teams;
  const EventsState({
    required this.eventsStatus,
    required this.events,
    required this.allEvents,
    required this.teams,
  });

  @override
  List<Object> get props => [eventsStatus, events, allEvents, teams];

  EventsState copyWith({
    EventsStatus? eventsStatus,
    List<EventModel>? events,
    List<EventModel>? allEvents,
    List<TeamModel>? teams,
  }) {
    return EventsState(
      eventsStatus: eventsStatus ?? this.eventsStatus,
      events: events ?? this.events,
      allEvents: allEvents ?? this.allEvents,
      teams: teams ?? this.teams,
    );
  }
}
