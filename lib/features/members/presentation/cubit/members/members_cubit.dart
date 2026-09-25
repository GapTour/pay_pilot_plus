import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/features/members/repository/member_repository.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final IMemberRepository _repository;
  MembersCubit(this._repository)
    : super(
        MembersState(
          membersStatus: MembersStatus.initial,
          members: [],
          allMembers: [],
        ),
      );

  void loadMembers() async {
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    final dataState = await _repository.fetchAllMembers();

    if (dataState.isSuccess) {
      final allMembers = dataState.response!;

      allMembers.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(
        state.copyWith(
          membersStatus: MembersStatus.success,
          members: allMembers,
          allMembers: allMembers,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void addMember(UserParams params) async {
    final allMembers = state.allMembers;
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    final dataState = await _repository.insertMember(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allMembers
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          membersStatus: MembersStatus.success,
          allMembers: allMembers,
          members: allMembers,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void updateMember(UserParams params) async {
    final allMembers = state.allMembers;
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    final dataState = await _repository.updateMember(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allMembers
        ..removeWhere((element) => element.id == newMember.id)
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          membersStatus: MembersStatus.success,
          allMembers: allMembers,
          members: allMembers,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void deleteMember(int memberID) async {
    final allMembers = state.allMembers;
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    final dataState = await _repository.archiveMember(memberID);

    if (dataState.isSuccess) {
      allMembers.removeWhere((element) => element.id == memberID);

      emit(
        state.copyWith(
          membersStatus: MembersStatus.success,
          allMembers: allMembers,
          members: allMembers,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void searchMember(String query) {
    emit(state.copyWith(membersStatus: MembersStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(
          membersStatus: MembersStatus.success,
          members: state.allMembers,
        ),
      );
      return;
    }

    final filteredMembers = state.allMembers.where((member) {
      return member.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(
        membersStatus: MembersStatus.success,
        members: filteredMembers,
      ),
    );
  }
}
