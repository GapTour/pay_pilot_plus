class TeamMemberParams {
  final int? id;
  final ({int id, String name}) userInfo;
  final ({int id, String name}) teamInfo;
  final double ratio;

  TeamMemberParams({
    required this.id,
    required this.teamInfo,
    required this.userInfo,
    required this.ratio,
  });
}
