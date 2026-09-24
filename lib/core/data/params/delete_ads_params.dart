class DeleteAdsParams {
  final int id;
  final int eventID;
  final BigInt expenseAmount;
  final DateTime paidAt;

  new({
    required this.id,
    required this.expenseAmount,
    required this.eventID,
    required this.paidAt,
  });
}
