import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/features/reports/repository/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final IReportRepository _repository;
  ReportBloc(this._repository)
    : super(
        ReportState(
          reportStatus: ReportStatus.initial,
          lines: [],
          subsidiaries: [],
          detailedAccounts: [],
        ),
      ) {
    on<ReportStarted>((event, emit) async {
      emit(state.copyWith(reportStatus: ReportStatus.loading));

      final subsidiariesState = await _repository.fetchAllSubsidiaries();
      final detailedState = await _repository.fetchAllDetailedAccounts();

      if (subsidiariesState.isFailed || detailedState.isFailed) {
        emit(state.copyWith(reportStatus: ReportStatus.failure));
        return;
      }

      emit(
        state.copyWith(
          subsidiaries: subsidiariesState.response!,
          detailedAccounts: detailedState.response!,
        ),
      );

      await _loadLines(emit);
    });
    on<ReportFromDateChanged>((event, emit) async {
      emit(state.copyWith(from: () => event.from));
      await _loadLines(emit);
    });
    on<ReportToDateChanged>((event, emit) async {
      // تا انتهای روز انتخاب‌شده را شامل شود
      final to = event.to == null
          ? null
          : DateTime(
              event.to!.year,
              event.to!.month,
              event.to!.day,
              23,
              59,
              59,
            );

      emit(state.copyWith(to: () => to));
      await _loadLines(emit);
    });
    on<ReportSubsidiaryChanged>((event, emit) async {
      emit(state.copyWith(selectedSubsidiary: () => event.subsidiary));
      await _loadLines(emit);
    });
    on<ReportDetailedChanged>((event, emit) async {
      emit(state.copyWith(selectedDetailed: () => event.detailed));
      await _loadLines(emit);
    });
    on<ReportFiltersCleared>((event, emit) async {
      emit(
        state.copyWith(
          from: () => null,
          to: () => null,
          selectedSubsidiary: () => null,
          selectedDetailed: () => null,
        ),
      );
      await _loadLines(emit);
    });
  }

  Future<void> _loadLines(Emitter<ReportState> emit) async {
    emit(state.copyWith(reportStatus: ReportStatus.loading));

    final dataState = await _repository.fetchLines(
      from: state.from,
      to: state.to,
      subsidiaryID: state.selectedSubsidiary?.id,
      detailedID: state.selectedDetailed?.id,
    );

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          reportStatus: ReportStatus.success,
          lines: dataState.response!,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(reportStatus: ReportStatus.failure));
    }
  }
}
