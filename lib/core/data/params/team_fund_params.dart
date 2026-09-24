class TeamFundParams {
  final int? id;
  final ({int id, String name}) fundInfo;
  final ({int id, String name}) teamInfo;
  final double ratio;

  TeamFundParams({
    required this.id,
    required this.teamInfo,
    required this.fundInfo,
    required this.ratio,
  });
}
