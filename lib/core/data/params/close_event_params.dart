class CloseEventParams {
  final int id;
  final String title;
  final DateTime date;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) hostInfo;
  final List<({int id, String name})> staffsInfo;
  final BigInt entranceFee;
  final BigInt snacksFee;
  final int totalRegisteredGuestsNumber;

  CloseEventParams({
    required this.id,
    required this.title,
    required this.date,
    required this.teamInfo,
    required this.hostInfo,
    required this.staffsInfo,
    required this.entranceFee,
    required this.snacksFee,
    required this.totalRegisteredGuestsNumber,
  });
}
