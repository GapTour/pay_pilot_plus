class TeamMemberModel {
  final int id;
  final int teamID;
  final ({int id, String name}) userInfo;
  final double sharePercentage;

  TeamMemberModel({
    required this.id,
    required this.teamID,
    required this.userInfo,
    required this.sharePercentage,
  });
}
