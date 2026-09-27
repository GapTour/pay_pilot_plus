import 'package:pay_pilot_plus/core/database/app_database.dart';

class GuestRegistrationJournalParams {
  final ({int id, String name, int accountID}) eventInfo;
  final ({int id, String name}) hostInfo;
  final List<({int id, String name})> usersInfo;
  final List<DetailedAccount> usersAccounts;
  final Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryAccountsMap;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final BigInt snacksFeeAmount;

  new({
    required this.eventInfo,
    required this.usersInfo,
    required this.usersAccounts,
    required this.subsidiaryAccountsMap,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.snacksFeeAmount,
    required this.hostInfo,
  });
}
