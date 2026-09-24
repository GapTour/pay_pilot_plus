import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/features/team_details/repository/team_details_repository.dart';

part 'ratios_state.dart';

class RatiosCubit extends Cubit<RatiosState> {
  final ITeamDetailsRepository _repository;
  RatiosCubit(this._repository)
    : super(
        RatiosState(
          teamRatiosStatus: .initial,
          memberRatios: [],
          fundRatios: [],
          members: [],
          funds: [],
          addedMembers: {},
          addedFunds: {},
        ),
      );

  void loadRatios(int? teamID) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    if (teamID == null) {
      emit(state.copyWith(teamRatiosStatus: .failure));
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

        emit(state.copyWith(memberRatios: teamMembers));
      }

      emit(state.copyWith(members: members, addedMembers: addedMembers));
    }

    if (memberDataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
      return;
    }

    final fundDataState = await _repository.fetchAllFunds();

    if (fundDataState.isSuccess) {
      final funds = fundDataState.response!;
      Map<int, double> addedFunds = {};

      final ratiosDataState = await _repository.fetchAllTeamFunds(teamID);

      if (ratiosDataState.isSuccess) {
        final teamFunds = ratiosDataState.response!;
        teamFunds.sort(
          (a, b) => a.sharePercentage.compareTo(b.sharePercentage),
        );
        addedFunds = await _updateAddedFundsList(teamFunds);

        emit(state.copyWith(fundRatios: teamFunds));
      }

      emit(
        state.copyWith(
          funds: funds,
          addedFunds: addedFunds,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (fundDataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
      return;
    }
  }

  void addMemberRatio(TeamMemberParams params) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.insertTeamMember(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamMembers = List<TeamMemberModel>.from(state.memberRatios)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          memberRatios: teamMembers,
          addedMembers: addedMembers,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
    }
  }

  void addFundRatio(TeamFundParams params) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.insertTeamFund(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamFunds = List<TeamFundModel>.from(state.fundRatios)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedFunds = await _updateAddedFundsList(teamFunds);

      emit(
        state.copyWith(
          fundRatios: teamFunds,
          addedFunds: addedFunds,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
    }
  }

  void updateMemberRatio(TeamMemberParams params) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.updateMemberRatio(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamMembers = List<TeamMemberModel>.from(state.memberRatios)
        ..removeWhere((pr) => pr.id == params.id)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          memberRatios: teamMembers,
          addedMembers: addedMembers,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
    }
  }

  void updateFundRatio(TeamFundParams params) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.updateFundRatio(params);

    if (dataState.isSuccess) {
      final newRatio = dataState.response!;

      final teamFunds = List<TeamFundModel>.from(state.fundRatios)
        ..removeWhere((pr) => pr.id == params.id)
        ..add(newRatio)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedFunds = await _updateAddedFundsList(teamFunds);

      emit(
        state.copyWith(
          fundRatios: teamFunds,
          addedFunds: addedFunds,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
    }
  }

  void deleteMemberRatio(int ratioID) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.deleteMemberRatio(ratioID);

    if (dataState.isSuccess) {
      final teamMembers = List<TeamMemberModel>.from(state.memberRatios)
        ..removeWhere((pr) => pr.id == ratioID)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          memberRatios: teamMembers,
          addedMembers: addedMembers,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
    }
  }

  void deleteFundRatio(int ratioID) async {
    emit(state.copyWith(teamRatiosStatus: .loading));

    final dataState = await _repository.deleteFundRatio(ratioID);

    if (dataState.isSuccess) {
      final teamFunds = List<TeamFundModel>.from(state.fundRatios)
        ..removeWhere((pr) => pr.id == ratioID)
        ..sort((a, b) => a.sharePercentage.compareTo(b.sharePercentage));

      final addedFunds = await _updateAddedFundsList(teamFunds);

      emit(
        state.copyWith(
          fundRatios: teamFunds,
          addedFunds: addedFunds,
          teamRatiosStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(teamRatiosStatus: .failure));
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

  Future<Map<int, double>> _updateAddedFundsList(
    List<TeamFundModel> teamFunds,
  ) async {
    final addedFunds = <int, double>{};

    teamFunds.fold<Map<int, double>>({}, (previousValue, crr) {
      if (!previousValue.containsKey(crr.fundInfo.id)) {
        addedFunds[crr.fundInfo.id] = crr.sharePercentage;
      }
      return previousValue;
    });

    return addedFunds;
  }
}
