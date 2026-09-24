class FundBalanceParams {
  final int? id;
  final int fundID;
  final int eventID;
  final DateTime date;
  final BigInt debit;
  final BigInt credit;
  FundBalanceParams({
    this.id,
    required this.fundID,
    required this.eventID,
    required this.date,
    required this.debit,
    required this.credit,
  });
}
