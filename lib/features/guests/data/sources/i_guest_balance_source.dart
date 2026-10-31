import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;

/// یک ثبت‌نام مهمان در یک رویداد
typedef GuestRegistration = ({
  int id,
  EventModel event,
  RegistrationStatus status,
  BigInt grossAmount,
  BigInt discountAmount,
  BigInt netAmount,
  bool wasAbsent,
});

abstract class IGuestBalanceSource<TBalances, TBigInt, TRegistrations> {
  Future<TBalances> fetchMemberBalance(int memberAccountID);
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
  Future<TRegistrations> fetchRegistrations(int userID);
}
