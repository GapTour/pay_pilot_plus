import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/features/funds/repository/fund_repository.dart';

part 'funds_state.dart';

class FundsCubit extends Cubit<FundsState> {
  final IFundRepository _repository;
  FundsCubit(this._repository)
    : super(FundsState(fundStatus: .initial, funds: [], allFunds: []));

  void loadFunds() async {
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.fetchAllFunds();

    if (dataState.isSuccess) {
      final allFunds = dataState.response!;

      allFunds.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      emit(
        state.copyWith(
          fundStatus: .success,
          funds: allFunds,
          allFunds: allFunds,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }

  void addFund(FundParams params) async {
    final allFunds = state.allFunds;
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.insertFund(params);

    if (dataState.isSuccess) {
      final newFund = dataState.response!;

      allFunds
        ..add(newFund)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          fundStatus: .success,
          allFunds: allFunds,
          funds: allFunds,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }

  void updateFund(FundParams params) async {
    final allFunds = state.allFunds;
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.updateFund(params);

    if (dataState.isSuccess) {
      final newFund = dataState.response!;

      allFunds
        ..removeWhere((element) => element.id == newFund.id)
        ..add(newFund)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          fundStatus: .success,
          allFunds: allFunds,
          funds: allFunds,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }

  void deleteFund(int fundID) async {
    final allFunds = state.allFunds;
    emit(state.copyWith(fundStatus: .loading));

    final dataState = await _repository.archiveFund(fundID);

    if (dataState.isSuccess) {
      allFunds.removeWhere((element) => element.id == fundID);

      emit(
        state.copyWith(
          fundStatus: .success,
          allFunds: allFunds,
          funds: allFunds,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(fundStatus: .failure));
    }
  }

  void searchFund(String query) {
    emit(state.copyWith(fundStatus: .loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(state.copyWith(fundStatus: .success, funds: state.allFunds));
      return;
    }

    final filteredMembers = state.allFunds.where((h) {
      return h.title.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(state.copyWith(fundStatus: .success, funds: filteredMembers));
  }
}
