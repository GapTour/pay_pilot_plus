import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_ratios_state.dart';

class EventRatiosCubit extends Cubit<EventRatiosState> {
  final IEventDetailsRepository _repository;

  EventRatiosCubit(this._repository)
    : super(
        EventRatiosState(
          memberRatios: List.empty(),
          fundRatios: List.empty(),
          ratioFetchStatus: .initial,
          ratioModificationStatus: .initial,
        ),
      );

  Future<void> initRatios(int eventID) async {
    emit(state.copyWith(ratioFetchStatus: .loading));

    final memberDataState = await _repository.fetchAllMemberRatios(eventID);

    if (memberDataState.isSuccess) {
      final ratios = List<TeamMemberModel>.from(memberDataState.response!);

      emit(state.copyWith(memberRatios: ratios));
    }

    if (memberDataState.isFailed) {
      emit(state.copyWith(ratioFetchStatus: .failure));
      return;
    }

    final fundDataState = await _repository.fetchAllFundRatios(eventID);

    if (fundDataState.isSuccess) {
      final ratios = List<TeamFundModel>.from(fundDataState.response!);

      emit(state.copyWith(fundRatios: ratios, ratioFetchStatus: .success));
    }

    if (fundDataState.isFailed) {
      emit(state.copyWith(ratioFetchStatus: .failure));
    }
  }

  void _changeModificationToInit() {
    emit(state.copyWith(ratioModificationStatus: .initial));
  }

  Future<void> addMemberRatio(MemberAllocationParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.insertMemberRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamMemberModel>.from(state.memberRatios)
        ..add(addedOrder);

      emit(
        state.copyWith(memberRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> addFundRatio(FundAllocationParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.insertFundRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamFundModel>.from(state.fundRatios)
        ..add(addedOrder);

      emit(
        state.copyWith(fundRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> editMemberRatio(MemberAllocationParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.updateMemberRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamMemberModel>.from(state.memberRatios)
        ..removeWhere((e) => e.id == params.id)
        ..add(addedOrder);

      emit(
        state.copyWith(memberRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> editFundRatio(FundAllocationParams params) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.updateFundRatio(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final ratios = List<TeamFundModel>.from(state.fundRatios)
        ..removeWhere((e) => e.id == params.id)
        ..add(addedOrder);

      emit(
        state.copyWith(fundRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> removeMemberRatio(int id) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.deleteMemberRatio(id);

    if (dataState.isSuccess) {
      final ratios = List<TeamMemberModel>.from(state.memberRatios)
        ..removeWhere((e) => e.id == id);

      emit(
        state.copyWith(memberRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }

  Future<void> removeFundRatio(int id) async {
    emit(state.copyWith(ratioModificationStatus: .loading));

    final dataState = await _repository.deleteFundRatio(id);

    if (dataState.isSuccess) {
      final ratios = List<TeamFundModel>.from(state.fundRatios)
        ..removeWhere((e) => e.id == id);

      emit(
        state.copyWith(fundRatios: ratios, ratioModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(ratioModificationStatus: .failure));
    }
  }
}
