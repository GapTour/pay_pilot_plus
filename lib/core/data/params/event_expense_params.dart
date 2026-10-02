import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SubsidiaryAccountType;

class EventExpenseParams {
  final SubsidiaryAccountType subsidiaryAccountType;
  final ({int id, String name}) eventInfo;
  final ({int id, String name})? bankInfo;
  final ({int id, String name})? fundInfo;
  final ({int id, String name})? staffInfo;
  final BigInt amount;
  final BigInt? transferFee;
  final DateTime paidAt;

  new({
    required this.subsidiaryAccountType,
    required this.eventInfo,
    required this.bankInfo,
    required this.fundInfo,
    required this.staffInfo,
    required this.amount,
    required this.transferFee,
    required this.paidAt,
  });
}
