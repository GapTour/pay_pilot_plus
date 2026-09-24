import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/features/journal_headers/repository/journals_repository.dart';

part 'journals_state.dart';

class JournalsCubit extends Cubit<JournalsState> {
  final IJournalsRepository _repository;
  JournalsCubit(this._repository)
    : super(
        JournalsState(journalsStatus: JournalsStatus.initial, journals: []),
      );

  void loadJournals(int headerID) async {
    emit(state.copyWith(journalsStatus: JournalsStatus.loading));

    final dataState = await _repository.fetchAllLines(headerID);

    if (dataState.isSuccess) {
      final allLines = dataState.response!;

      emit(
        state.copyWith(
          journalsStatus: JournalsStatus.success,
          journals: allLines,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(journalsStatus: JournalsStatus.failure));
    }
  }
}
