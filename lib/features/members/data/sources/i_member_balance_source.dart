import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';

abstract class IMemberBalanceSource<TBalances, TBigInt> {
  Future<TBalances> fetchMemberBalance(int memberAccountID);
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
}
