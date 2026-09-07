class EventParams {
  final int? id;
  final String title;
  final DateTime date;
  final ({int id, String name}) teamInfo;
  final bool isClosed;

  EventParams({
    required this.id,
    required this.title,
    required this.date,
    required this.teamInfo,
    required this.isClosed,
  });
}
