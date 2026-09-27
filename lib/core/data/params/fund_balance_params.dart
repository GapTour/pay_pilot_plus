class FundBalanceParams {
  final int? id;
  final int fundID;
  final String series;
  final String? memo;
  final DateTime date;
  final BigInt debit;
  final BigInt credit;
  FundBalanceParams({
    this.id,
    required this.fundID,
    required this.series,
    required this.memo,
    required this.date,
    required this.debit,
    required this.credit,
  });
}
