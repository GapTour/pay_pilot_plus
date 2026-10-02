import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/close_event_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';
import 'package:pay_pilot_plus/features/events/repository/event_repository.dart';

part 'event_modification_event.dart';
part 'event_modification_state.dart';
part 'status/close_event_status.dart';
part 'status/open_event_status.dart';

class EventModificationBloc
    extends Bloc<EventModificationEvent, EventModificationState> {
  final IEventRepository _repository;
  EventModificationBloc(this._repository)
    : super(
        EventModificationState(
          closeEventStatus: CloseEventInitial(),
          openEventStatus: OpenEventStatus(),
          configurationsStatus: .initial,
          registeredGuests: [],
          allUsers: [],
          openedEvent: null,
        ),
      ) {
    on<CloseEvent>(_closeEvent);
    on<OpenEvent>(_openEvent);
    on<InitConfigurations>(_initConfigurations);
  }

  Future<void> _initConfigurations(
    InitConfigurations event,
    Emitter<EventModificationState> emit,
  ) async {
    emit(state.copyWith(configurationsStatus: .loading));

    final registeredDataState = await _repository.fetchRegisteredGuestsID(
      event.openedEvent.id,
    );
    final usersDataState = await _repository.fetchAllUsers();

    if (registeredDataState.isFailed || usersDataState.isFailed) {
      emit(state.copyWith(configurationsStatus: .failure));
    }

    if (registeredDataState.isSuccess && usersDataState.isSuccess) {
      emit(
        state.copyWith(
          openedEvent: event.openedEvent,
          registeredGuests: List<int>.from(registeredDataState.response!),
          allUsers: List<UserModel>.from(usersDataState.response!),
          configurationsStatus: .success,
        ),
      );
    }
  }

  Future<void> _closeEvent(
    CloseEvent event,
    Emitter<EventModificationState> emit,
  ) async {
    emit(state.copyWith(closeEventStatus: CloseEventLoading()));

    final dataState = await _repository.closeEvent(event.params);

    if (dataState.isSuccess) {
      final closedEvent = state.openedEvent!.copyWith(
        entranceFee: event.params.entranceFee,
        snacksFee: event.params.snacksFee,
        isClosed: true,
      );

      emit(state.copyWith(closeEventStatus: CloseEventSuccess(closedEvent)));
    }

    if (dataState.isFailed) {
      emit(
        state.copyWith(closeEventStatus: CloseEventFailure(dataState.error!)),
      );
    }
  }

  Future<void> _openEvent(
    OpenEvent event,
    Emitter<EventModificationState> emit,
  ) async {
    emit(state.copyWith(openEventStatus: OpenEventLoading()));

    final dataState = await _repository.openEvent(event.eventID);

    if (dataState.isSuccess) {
      emit(state.copyWith(openEventStatus: OpenEventSuccess()));
    }

    if (dataState.isFailed) {
      emit(state.copyWith(openEventStatus: OpenEventFailure(dataState.error!)));
    }
  }
}
