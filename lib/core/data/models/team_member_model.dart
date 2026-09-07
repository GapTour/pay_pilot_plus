class TeamMemberModel {
  final int id;
  final int teamID;
  final int userID;
  final String name;
  final double sharePercentage;

  TeamMemberModel({
    required this.id,
    required this.teamID,
    required this.userID,
    required this.name,
    required this.sharePercentage,
  });
}
