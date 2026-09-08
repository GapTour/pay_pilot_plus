import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_params.dart';
import 'package:pay_pilot_plus/features/teams/repository/team_repository.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final ITeamRepository _repository;
  TeamsCubit(this._repository)
    : super(
        TeamsState(teamsStatus: TeamsStatus.initial, teams: [], allTeams: []),
      );

  void loadTeams() async {
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.fetchAllTeams();

    if (dataState.isSuccess) {
      final allTeams = dataState.response!;

      allTeams.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      emit(
        state.copyWith(
          teamsStatus: TeamsStatus.success,
          teams: allTeams,
          allTeams: allTeams,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void addMember(TeamParams params) async {
    final allTeams = state.allTeams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.insertTeam(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allTeams
        ..add(newMember)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          teamsStatus: TeamsStatus.success,
          allTeams: allTeams,
          teams: allTeams,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void updateMember(TeamParams params) async {
    final allTeams = state.allTeams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.updateTeam(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allTeams
        ..removeWhere((element) => element.id == newMember.id)
        ..add(newMember)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          teamsStatus: TeamsStatus.success,
          allTeams: allTeams,
          teams: allTeams,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void deleteMember(int teamID) async {
    final allTeams = state.allTeams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.archiveTeam(teamID);

    if (dataState.isSuccess) {
      allTeams.removeWhere((element) => element.id == teamID);

      emit(
        state.copyWith(
          teamsStatus: TeamsStatus.success,
          allTeams: allTeams,
          teams: allTeams,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void searchMember(String query) {
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(teamsStatus: TeamsStatus.success, teams: state.allTeams),
      );
      return;
    }

    final filteredMembers = state.allTeams.where((h) {
      return h.title.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(teamsStatus: TeamsStatus.success, teams: filteredMembers),
    );
  }
}
