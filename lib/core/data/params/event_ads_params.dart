class EventAdsParams {
  final int? id;
  final ({int id, String name}) eventInfo;
  final ({int id, String name})? bankInfo;
  final ({int id, String name})? staffInfo;
  final BigInt adsAmount;
  final DateTime paidAt;
  final String description;

  new({
    required this.id,
    required this.eventInfo,
    required this.bankInfo,
    required this.staffInfo,
    required this.adsAmount,
    required this.paidAt,
    required this.description,
  });
}
