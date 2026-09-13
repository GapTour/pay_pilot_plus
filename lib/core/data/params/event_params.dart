class EventParams {
  final int? id;
  final String title;
  final DateTime date;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) userInfo;
  final bool isClosed;
  final BigInt entranceFee;
  final BigInt snacksFee;

  EventParams({
    required this.id,
    required this.title,
    required this.date,
    required this.teamInfo,
    required this.userInfo,
    required this.isClosed,
    required this.entranceFee,
    required this.snacksFee,
  });
}
