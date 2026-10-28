part of 'salary_report_cubit.dart';

enum SalaryReportStatus { initial, loading, success, failure }

@immutable
class SalaryReportState extends Equatable {
  final SalaryReportStatus salaryReportStatus;
  final List<MemberSalarySummaryModel> summaries;
  final List<AccountInfo> events;
  final DateTime? from;
  final DateTime? to;
  final AccountInfo? selectedEvent;

  const SalaryReportState({
    required this.salaryReportStatus,
    required this.summaries,
    required this.events,
    this.from,
    this.to,
    this.selectedEvent,
  });

  BigInt get totalSalary =>
      summaries.fold(BigInt.zero, (sum, s) => sum + s.totalSalary);

  bool get hasFilters => from != null || to != null || selectedEvent != null;

  @override
  List<Object?> get props => [
    salaryReportStatus,
    summaries,
    events,
    from,
    to,
    selectedEvent,
  ];

  /// فیلدهای نال‌پذیر با ValueGetter ارسال می‌شوند تا بتوان آن‌ها را پاک کرد
  SalaryReportState copyWith({
    SalaryReportStatus? salaryReportStatus,
    List<MemberSalarySummaryModel>? summaries,
    List<AccountInfo>? events,
    ValueGetter<DateTime?>? from,
    ValueGetter<DateTime?>? to,
    ValueGetter<AccountInfo?>? selectedEvent,
  }) {
    return SalaryReportState(
      salaryReportStatus: salaryReportStatus ?? this.salaryReportStatus,
      summaries: summaries ?? this.summaries,
      events: events ?? this.events,
      from: from != null ? from() : this.from,
      to: to != null ? to() : this.to,
      selectedEvent: selectedEvent != null
          ? selectedEvent()
          : this.selectedEvent,
    );
  }
}
