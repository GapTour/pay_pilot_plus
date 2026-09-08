import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/features/team_members/repository/team_member_repository.dart';

part 'ratios_state.dart';

class RatiosCubit extends Cubit<RatiosState> {
  final ITeamMemberRepository _repository;
  RatiosCubit(this._repository)
    : super(
        RatiosState(
          teamMemberStatus: .initial,
          ratios: [],
          members: [],
          addedMembers: {},
        ),
      );

  void loadRatios(int? teamID) async {
    emit(state.copyWith(teamMemberStatus: .loading));

    if (teamID == null) {
      emit(state.copyWith(teamMemberStatus: .failure));
      return;
    }

    final memberDataState = await _repository.fetchAllMembers();

    if (memberDataState.isSuccess) {
      final members = memberDataState.response!;
      Map<int, double> addedMembers = {};

      final ratiosDataState = await _repository.fetchAllTeamMembers(teamID);

      if (ratiosDataState.isSuccess) {
        final teamMembers = ratiosDataState.response!;
        teamMembers.sort(
          (a, b) => a.sharePercentage.compareTo(b.sharePercentage),
        );
        addedMembers = await _updateAddedMembersList(teamMembers);

        emit(state.copyWith(ratios: teamMembers));
      }

      emit(
        state.copyWith(
          members: members,
          addedMembers: addedMembers,
          teamMemberStatus: .success,
        ),
      );
    }

    if (memberDataState.isFailed) {
      emit(state.copyWith(teamMemberStatus: .failure));
    }
  }

  void addRatio(TeamMemberParams params) async {
    emit(state.copyWith(teamMemberStatus: .loading));

    final dataState = await _repository.insertTeamMember(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamMembers = List<TeamMemberModel>.from(state.ratios)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          addedMembers: addedMembers,
          teamMemberStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamMemberStatus: .failure));
    }
  }

  void updateRatio(TeamMemberParams params) async {
    emit(state.copyWith(teamMemberStatus: .loading));

    final dataState = await _repository.updateRatio(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamMembers = List<TeamMemberModel>.from(state.ratios)
        ..removeWhere((pr) => pr.id == params.id)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          addedMembers: addedMembers,
          teamMemberStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamMemberStatus: .failure));
    }
  }

  void deleteRatio(int ratioID) async {
    emit(state.copyWith(teamMemberStatus: .loading));

    final dataState = await _repository.deleteRatio(ratioID);

    if (dataState.isSuccess) {
      final teamMembers = List<TeamMemberModel>.from(state.ratios)
        ..removeWhere((pr) => pr.id == ratioID)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          addedMembers: addedMembers,
          teamMemberStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamMemberStatus: .failure));
    }
  }

  Future<Map<int, double>> _updateAddedMembersList(
    List<TeamMemberModel> teamMembers,
  ) async {
    final addedMembers = <int, double>{};

    teamMembers.fold<Map<int, double>>({}, (previousValue, crr) {
      if (!previousValue.containsKey(crr.userInfo.id)) {
        addedMembers[crr.userInfo.id] = crr.sharePercentage;
      }
      return previousValue;
    });

    return addedMembers;
  }
}
