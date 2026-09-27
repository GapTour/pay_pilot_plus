class EventParams {
  final int? id;
  final String title;
  final DateTime date;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) hostInfo;
  final bool isClosed;
  final BigInt entranceFee;
  final BigInt snacksFee;

  EventParams({
    required this.id,
    required this.title,
    required this.date,
    required this.teamInfo,
    required this.hostInfo,
    required this.isClosed,
    required this.entranceFee,
    required this.snacksFee,
  });
}
