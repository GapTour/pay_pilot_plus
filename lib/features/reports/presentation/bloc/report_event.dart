part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

/// بارگذاری حساب‌ها برای فیلتر و اولین گزارش
final class ReportStarted extends ReportEvent {}

final class ReportFromDateChanged extends ReportEvent {
  final DateTime? from;
  const ReportFromDateChanged(this.from);

  @override
  List<Object?> get props => [from];
}

final class ReportToDateChanged extends ReportEvent {
  final DateTime? to;
  const ReportToDateChanged(this.to);

  @override
  List<Object?> get props => [to];
}

final class ReportSubsidiaryChanged extends ReportEvent {
  final SubsidiaryModel? subsidiary;
  const ReportSubsidiaryChanged(this.subsidiary);

  @override
  List<Object?> get props => [subsidiary?.id];
}

final class ReportDetailedChanged extends ReportEvent {
  final DetailedAccountModel? detailed;
  const ReportDetailedChanged(this.detailed);

  @override
  List<Object?> get props => [detailed?.id];
}

final class ReportFiltersCleared extends ReportEvent {}
