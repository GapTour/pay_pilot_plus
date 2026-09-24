class EventEntranceFeeParams {
  final int? id;
  final ({int id, String name}) eventInfo;
  final ({int id, String name}) bankInfo;
  final List<({int id, String name})> staffsInfo;
  final ({int id, String name}) hostInfo;
  final BigInt entranceFee;
  final BigInt snacksFee;
  final BigInt totalExpenseAmount;
  final int totalGuests;
  final DateTime paidAt;
  final String? description;

  new({
    required this.id,
    required this.eventInfo,
    required this.bankInfo,
    required this.staffsInfo,
    required this.hostInfo,
    required this.entranceFee,
    required this.snacksFee,
    required this.totalExpenseAmount,
    required this.totalGuests,
    required this.paidAt,
    required this.description,
  });
}
