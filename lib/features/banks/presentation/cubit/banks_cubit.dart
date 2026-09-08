import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/features/banks/repository/bank_repository.dart';

part 'banks_state.dart';

class BanksCubit extends Cubit<BanksState> {
  final IBankRepository _repository;
  BanksCubit(this._repository)
    : super(
        BanksState(banksStatus: BanksStatus.initial, banks: [], allBanks: []),
      );

  void loadBanks() async {
    emit(state.copyWith(banksStatus: BanksStatus.loading));

    final dataState = await _repository.fetchAllBanks();

    if (dataState.isSuccess) {
      final allBanks = dataState.response!;

      allBanks.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(
        state.copyWith(
          banksStatus: BanksStatus.success,
          banks: allBanks,
          allBanks: allBanks,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(banksStatus: BanksStatus.failure));
    }
  }

  void addBank(BankParams params) async {
    final allBanks = state.allBanks;
    emit(state.copyWith(banksStatus: BanksStatus.loading));

    final dataState = await _repository.insertBank(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allBanks
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          banksStatus: BanksStatus.success,
          allBanks: allBanks,
          banks: allBanks,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(banksStatus: BanksStatus.failure));
    }
  }

  void updateBank(BankParams params) async {
    final allBanks = state.allBanks;
    emit(state.copyWith(banksStatus: BanksStatus.loading));

    final dataState = await _repository.updateBank(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allBanks
        ..removeWhere((element) => element.bankID == newMember.bankID)
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(
          banksStatus: BanksStatus.success,
          allBanks: allBanks,
          banks: allBanks,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(banksStatus: BanksStatus.failure));
    }
  }

  void deleteBank(int bankID) async {
    final allBanks = state.allBanks;
    emit(state.copyWith(banksStatus: BanksStatus.loading));

    final dataState = await _repository.archiveBank(bankID);

    if (dataState.isSuccess) {
      allBanks.removeWhere((element) => element.bankID == bankID);

      emit(
        state.copyWith(
          banksStatus: BanksStatus.success,
          allBanks: allBanks,
          banks: allBanks,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(banksStatus: BanksStatus.failure));
    }
  }

  void searchBank(String query) {
    emit(state.copyWith(banksStatus: BanksStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(banksStatus: BanksStatus.success, banks: state.allBanks),
      );
      return;
    }

    final filteredMembers = state.allBanks.where((bank) {
      return bank.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(
      state.copyWith(banksStatus: BanksStatus.success, banks: filteredMembers),
    );
  }
}
