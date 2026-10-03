class BankBalanceParams {
  final ({int id, String name}) bankInfo;
  final ({int id, String name})? eventInfo;
  final ({int id, String name})? fundInfo;
  final ({int id, String name}) userInfo;
  final BigInt amount;
  final BigInt transferFee;
  final DateTime paidAt;

  new({
    required this.bankInfo,
    required this.eventInfo,
    required this.fundInfo,
    required this.userInfo,
    required this.amount,
    required this.transferFee,
    required this.paidAt,
  });
}
