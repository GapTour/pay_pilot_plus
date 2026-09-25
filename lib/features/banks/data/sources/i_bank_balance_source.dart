import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';

abstract class IBankBalanceSource<TBalances, TBigInt, TFunds> {
  Future<TBalances> fetchBankBalance(int bankAccountID);
  Future<TFunds> fetchAllFunds();
  Future<TBigInt> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  });
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
}
