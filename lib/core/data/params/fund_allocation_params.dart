class FundAllocationParams {
  final int? id;
  final List<({int id, String name, double ratio})> fundsInfo;
  final ({int id, String name}) eventInfo;

  FundAllocationParams({
    required this.id,
    required this.eventInfo,
    required this.fundsInfo,
  });
}
