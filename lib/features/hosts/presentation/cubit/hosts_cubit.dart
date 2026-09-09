import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/features/hosts/repository/host_repository.dart';

part 'hosts_state.dart';

class HostsCubit extends Cubit<HostsState> {
  final IHostRepository _repository;
  HostsCubit(this._repository)
    : super(
        HostsState(hostsStatus: HostsStatus.initial, hosts: [], allHosts: []),
      );

  void loadMembers() async {
    emit(state.copyWith(hostsStatus: HostsStatus.loading));

    final dataState = await _repository.fetchAllHosts();

    if (dataState.isSuccess) {
      final allHosts = dataState.response!;

      allHosts.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(
        state.copyWith(
          hostsStatus: HostsStatus.success,
          hosts: allHosts,
          allHosts: allHosts,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(hostsStatus: HostsStatus.failure));
    }
  }

  void addMember(UserParams params) async {
    final allHosts = state.allHosts;
    emit(state.copyWith(hostsStatus: HostsStatus.loading));

    final dataState = await _repository.insertHost(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allHosts
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          hostsStatus: HostsStatus.success,
          allHosts: allHosts,
          hosts: allHosts,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(hostsStatus: HostsStatus.failure));
    }
  }

  void updateMember(UserParams params) async {
    final allHosts = state.allHosts;
    emit(state.copyWith(hostsStatus: HostsStatus.loading));

    final dataState = await _repository.updateHost(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allHosts
        ..removeWhere((element) => element.id == newMember.id)
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          hostsStatus: HostsStatus.success,
          allHosts: allHosts,
          hosts: allHosts,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(hostsStatus: HostsStatus.failure));
    }
  }

  void deleteMember(int hostID) async {
    final allHosts = state.allHosts;
    emit(state.copyWith(hostsStatus: HostsStatus.loading));

    final dataState = await _repository.archiveHost(hostID);

    if (dataState.isSuccess) {
      allHosts.removeWhere((element) => element.id == hostID);

      emit(
        state.copyWith(
          hostsStatus: HostsStatus.success,
          allHosts: allHosts,
          hosts: allHosts,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(hostsStatus: HostsStatus.failure));
    }
  }

  void searchMember(String query) {
    emit(state.copyWith(hostsStatus: HostsStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(hostsStatus: HostsStatus.success, hosts: state.allHosts),
      );
      return;
    }

    final filteredMembers = state.allHosts.where((h) {
      return h.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(hostsStatus: HostsStatus.success, hosts: filteredMembers),
    );
  }
}
