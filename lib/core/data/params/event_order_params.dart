class EventOrderParams {
  final int? id;
  final ({int id, String name}) userInfo;
  final ({int id, String name}) eventInfo;
  final List<int> menuItemIDs;

  EventOrderParams({
    required this.id,
    required this.eventInfo,
    required this.userInfo,
    required this.menuItemIDs,
  });
}
