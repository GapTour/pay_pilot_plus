class EventModel {
  final int id;
  final String title;
  final DateTime date;
  final bool isClosed;
  final ({int id, String name}) teamInfo;
  final ({int id, String name, String code}) detailedAccountInfo;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isClosed,
    required this.detailedAccountInfo,
    required this.teamInfo,
  });
}
