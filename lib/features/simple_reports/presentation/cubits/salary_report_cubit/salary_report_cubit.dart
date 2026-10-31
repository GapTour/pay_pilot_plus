import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/features/simple_reports/data/providers/simple_report_local_provider.dart';
import 'package:pay_pilot_plus/features/simple_reports/repository/simple_report_repository.dart';

part 'salary_report_state.dart';

class SalaryReportCubit extends Cubit<SalaryReportState> {
  final ISimpleReportRepository _repository;
  SalaryReportCubit(this._repository)
    : super(
        SalaryReportState(
          salaryReportStatus: SalaryReportStatus.initial,
          summaries: [],
          events: [],
        ),
      );

  void loadReport() async {
    emit(state.copyWith(salaryReportStatus: SalaryReportStatus.loading));

    final eventsState = await _repository.fetchEventAccounts();

    if (eventsState.isFailed) {
      emit(state.copyWith(salaryReportStatus: SalaryReportStatus.failure));
      return;
    }

    emit(state.copyWith(events: eventsState.response!));
    await _loadSummaries();
  }

  void changeFromDate(DateTime? from) async {
    emit(state.copyWith(from: () => from));
    await _loadSummaries();
  }

  void changeToDate(DateTime? to) async {
    // تا انتهای روز انتخاب‌شده را شامل شود
    final endOfDay = to == null
        ? null
        : DateTime(to.year, to.month, to.day, 23, 59, 59);

    emit(state.copyWith(to: () => endOfDay));
    await _loadSummaries();
  }

  void changeEvent(AccountInfo? event) async {
    emit(state.copyWith(selectedEvent: () => event));
    await _loadSummaries();
  }

  void clearFilters() async {
    emit(
      state.copyWith(
        from: () => null,
        to: () => null,
        selectedEvent: () => null,
      ),
    );
    await _loadSummaries();
  }

  Future<void> _loadSummaries() async {
    emit(state.copyWith(salaryReportStatus: SalaryReportStatus.loading));

    final dataState = await _repository.fetchMemberSalarySummaries(
      from: state.from,
      to: state.to,
      eventAccountID: state.selectedEvent?.id,
    );

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          salaryReportStatus: SalaryReportStatus.success,
          summaries: dataState.response!,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(salaryReportStatus: SalaryReportStatus.failure));
    }
  }
}
