part of 'report_bloc.dart';

enum ReportStatus { initial, loading, success, failure }

class ReportState extends Equatable {
  final ReportStatus reportStatus;
  final List<JournalLineModel> lines;
  final List<SubsidiaryModel> subsidiaries;
  final List<DetailedAccountModel> detailedAccounts;
  final DateTime? from;
  final DateTime? to;
  final SubsidiaryModel? selectedSubsidiary;
  final DetailedAccountModel? selectedDetailed;

  const ReportState({
    required this.reportStatus,
    required this.lines,
    required this.subsidiaries,
    required this.detailedAccounts,
    this.from,
    this.to,
    this.selectedSubsidiary,
    this.selectedDetailed,
  });

  BigInt get totalDebit =>
      lines.fold(BigInt.zero, (sum, line) => sum + line.debit);

  BigInt get totalCredit =>
      lines.fold(BigInt.zero, (sum, line) => sum + line.credit);

  BigInt get balance => totalDebit - totalCredit;

  bool get hasFilters =>
      from != null ||
      to != null ||
      selectedSubsidiary != null ||
      selectedDetailed != null;

  @override
  List<Object?> get props => [
    reportStatus,
    lines,
    subsidiaries,
    detailedAccounts,
    from,
    to,
    selectedSubsidiary?.id,
    selectedDetailed?.id,
  ];

  /// فیلدهای نال‌پذیر با ValueGetter ارسال می‌شوند تا بتوان آن‌ها را پاک کرد
  ReportState copyWith({
    ReportStatus? reportStatus,
    List<JournalLineModel>? lines,
    List<SubsidiaryModel>? subsidiaries,
    List<DetailedAccountModel>? detailedAccounts,
    ValueGetter<DateTime?>? from,
    ValueGetter<DateTime?>? to,
    ValueGetter<SubsidiaryModel?>? selectedSubsidiary,
    ValueGetter<DetailedAccountModel?>? selectedDetailed,
  }) {
    return ReportState(
      reportStatus: reportStatus ?? this.reportStatus,
      lines: lines ?? this.lines,
      subsidiaries: subsidiaries ?? this.subsidiaries,
      detailedAccounts: detailedAccounts ?? this.detailedAccounts,
      from: from != null ? from() : this.from,
      to: to != null ? to() : this.to,
      selectedSubsidiary: selectedSubsidiary != null
          ? selectedSubsidiary()
          : this.selectedSubsidiary,
      selectedDetailed: selectedDetailed != null
          ? selectedDetailed()
          : this.selectedDetailed,
    );
  }
}
