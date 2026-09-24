import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/features/journal_headers/repository/journals_repository.dart';

part 'headers_state.dart';

class HeadersCubit extends Cubit<HeadersState> {
  final IJournalsRepository _repository;
  HeadersCubit(this._repository)
    : super(
        HeadersState(
          headersStatus: HeadersStatus.initial,
          headers: [],
          allHeaders: [],
        ),
      );

  void loadHeaders() async {
    emit(state.copyWith(headersStatus: HeadersStatus.loading));

    final dataState = await _repository.fetchAllHeaders();

    if (dataState.isSuccess) {
      final allHeaders = dataState.response!;

      allHeaders.sort((a, b) => a.entryDate.compareTo(b.entryDate));

      emit(
        state.copyWith(
          headersStatus: HeadersStatus.success,
          headers: allHeaders,
          allHeaders: allHeaders,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(headersStatus: HeadersStatus.failure));
    }
  }

  void searchHeader(String query) {
    emit(state.copyWith(headersStatus: HeadersStatus.loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(
          headersStatus: HeadersStatus.success,
          headers: state.allHeaders,
        ),
      );
      return;
    }

    final filteredMembers = state.allHeaders.where((h) {
      return h.description?.toLowerCase().contains(normalizedQuery) ?? false;
    }).toList();

    emit(
      state.copyWith(
        headersStatus: HeadersStatus.success,
        headers: filteredMembers,
      ),
    );
  }
}
