class MemberAllocationParams {
  final int? id;
  final List<({int id, String name, double ratio})> usersInfo;
  final ({int id, String name}) eventInfo;

  MemberAllocationParams({
    required this.id,
    required this.eventInfo,
    required this.usersInfo,
  });
}
