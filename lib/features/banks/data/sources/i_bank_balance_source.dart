import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';

abstract class IBankBalanceSource<TList, TBigInt> {
  Future<TList> fetchBankBalance(int bankAccountID);
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
}
