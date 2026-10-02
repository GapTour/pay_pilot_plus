part of 'events_cubit.dart';

class EventsState extends Equatable {
  final EventsStatus eventsStatus;
  final List<EventModel> events;
  final List<EventModel> allEvents;
  final List<TeamModel> teams;
  final List<UserModel> hosts;
  const EventsState({
    required this.eventsStatus,
    required this.events,
    required this.allEvents,
    required this.teams,
    required this.hosts,
  });

  @override
  List<Object> get props {
    return [eventsStatus, events, allEvents, teams, hosts];
  }

  EventsState copyWith({
    EventsStatus? eventsStatus,
    List<EventModel>? events,
    List<EventModel>? allEvents,
    List<TeamModel>? teams,
    List<UserModel>? hosts,
  }) {
    return EventsState(
      eventsStatus: eventsStatus ?? this.eventsStatus,
      events: events ?? this.events,
      allEvents: allEvents ?? this.allEvents,
      teams: teams ?? this.teams,
      hosts: hosts ?? this.hosts,
    );
  }
}
