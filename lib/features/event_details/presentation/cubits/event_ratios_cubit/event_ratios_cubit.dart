import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_ratios_state.dart';

class EventRatiosCubit extends Cubit<EventRatiosState> {
  final IEventDetailsRepository _repository;

  EventRatiosCubit(this._repository)
    : super(
        EventRatiosState(
          ratios: List.empty(),
          ratioFetchStatus: .initial,
          ratioModificationStatus: .initial,
        ),
      );

  Future<void> initRatios(int eventID) async {
    emit(state.copyWith(ratioFetchStatus: .loading));

    final dataState = await _repository.fetchAllRatios(eventID);

    if (dataState.isSuccess) {
      final ratios = List<TeamMemberModel>.from(dataState.response!);

      emit(state.copyWith(ratios: ratios, ratioFetchStatus: .success));
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioFetchStatus: .failure));
    }
  }

  void _changeModificationToInit() {
    emit(state.copyWith(ratioModificationStatus: .initial));
  }

  Future<void> addRatio(EventPartnerShareParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.insertRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamMemberModel>.from(state.ratios)..add(addedOrder);

      emit(state.copyWith(ratios: ratios, ratioModificationStatus: .success));
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> editRatio(EventPartnerShareParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.updateRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamMemberModel>.from(state.ratios)
        ..removeWhere((e) => e.id == params.id)
        ..add(addedOrder);

      emit(state.copyWith(ratios: ratios, ratioModificationStatus: .success));
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> removeRatio(int id) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.deleteRatio(id);

    if (dataState.isSuccess) {
      final ratios = List<TeamMemberModel>.from(state.ratios)
        ..removeWhere((e) => e.id == id);

      emit(state.copyWith(ratios: ratios, ratioModificationStatus: .success));
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }
}
