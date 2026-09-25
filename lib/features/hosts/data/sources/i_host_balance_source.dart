import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';

abstract class IHostBalanceSource<TBalances, TBigInt> {
  Future<TBalances> fetchHostBalance(int hostAccountID);
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
}
