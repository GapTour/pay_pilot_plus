import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/features/events/repository/event_repository.dart';

part 'events_state.dart';
part 'status/events_status.dart';

class EventsCubit extends Cubit<EventsState> {
  final IEventRepository _repository;
  EventsCubit(this._repository)
    : super(
        EventsState(
          eventsStatus: EventInitial(),
          events: [],
          teams: [],
          hosts: [],
          allEvents: [],
        ),
      );

  void loadEvents() async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final eventsDataState = await _repository.fetchAllEvents();

    if (eventsDataState.isSuccess) {
      final allEvents = eventsDataState.response!
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(
          eventsStatus: EventSuccess(),
          events: allEvents,
          allEvents: allEvents,
        ),
      );

      final teamsDataState = await _repository.fetchAllTeams();

      if (teamsDataState.isSuccess) {
        emit(
          state.copyWith(
            teams: teamsDataState.response!
              ..sort(
                (a, b) =>
                    a.title.toLowerCase().compareTo(b.title.toLowerCase()),
              ),
          ),
        );
      }

      final hostsDataState = await _repository.fetchAllHosts();

      if (hostsDataState.isSuccess) {
        emit(
          state.copyWith(
            hosts: hostsDataState.response!
              ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              ),
          ),
        );
      }
    }

    if (eventsDataState.isFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void addEvent(EventParams params) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.insertEvent(params);

    if (dataState.isSuccess) {
      final allEvents = List<EventModel>.from(state.allEvents)
        ..add(dataState.response!)
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(
          eventsStatus: EventSuccess(),
          allEvents: allEvents,
          events: allEvents,
        ),
      );
    }
    if (dataState.isFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void editEvent(EventParams params) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.updateEvent(params);

    if (dataState.isSuccess) {
      final allEvents = List<EventModel>.from(state.allEvents)
        ..removeWhere((element) => element.id == params.id)
        ..add(dataState.response!)
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(
          eventsStatus: EventSuccess(),
          allEvents: allEvents,
          events: allEvents,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void deleteEvent(int eventID) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.archiveEvent(eventID);

    if (dataState.isSuccess) {
      final allEvents = List<EventModel>.from(state.allEvents)
        ..removeWhere((element) => element.id == eventID)
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(
          eventsStatus: EventSuccess(),
          allEvents: allEvents,
          events: allEvents,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void searchEvent(String query) {
    emit(state.copyWith(eventsStatus: EventLoading()));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(eventsStatus: EventSuccess(), events: state.allEvents),
      );

      return;
    }

    final filteredEvents = state.allEvents.where((event) {
      return event.title.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(state.copyWith(eventsStatus: EventSuccess(), events: filteredEvents));
  }

  void closeEvent(EventModel closedEvent) {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final openedEvent = state.allEvents.firstWhere(
      (e) => e.id == closedEvent.id,
    );
    final index = state.allEvents.indexOf(openedEvent);
    final allEvents = List<EventModel>.from(state.allEvents)
      ..removeAt(index)
      ..insert(index, closedEvent);

    emit(
      state.copyWith(
        eventsStatus: EventSuccess(),
        allEvents: allEvents,
        events: allEvents,
      ),
    );
  }

  void openEvent(int eventID) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final closedEvent = state.allEvents.firstWhere((e) => e.id == eventID);
    final index = state.allEvents.indexOf(closedEvent);
    final openedEvent = closedEvent.copyWith(
      entranceFee: BigInt.zero,
      snacksFee: BigInt.zero,
      isClosed: false,
    );
    final allEvents = List<EventModel>.from(state.allEvents)
      ..removeAt(index)
      ..insert(index, openedEvent);

    emit(
      state.copyWith(
        eventsStatus: EventSuccess(),
        allEvents: allEvents,
        events: allEvents,
      ),
    );
  }
}
