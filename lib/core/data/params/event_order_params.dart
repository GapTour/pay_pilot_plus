class EventOrderParams {
  final int? id;
  final int eventID;
  final ({int id, String name}) userInfo;
  final List<int> menuItemIDs;

  EventOrderParams({
    required this.id,
    required this.eventID,
    required this.userInfo,
    required this.menuItemIDs,
  });
}
