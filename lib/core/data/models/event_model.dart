class EventModel {
  final int eventID;
  final int detailsAccountID;
  final String accountCode;
  final String accountName;
  final String title;
  final DateTime date;
  final bool isClosed;
  final String teamName;
  final int teamID;

  EventModel({
    required this.eventID,
    required this.detailsAccountID,
    required this.accountCode,
    required this.accountName,
    required this.title,
    required this.date,
    required this.isClosed,
    required this.teamName,
    required this.teamID,
  });
}
