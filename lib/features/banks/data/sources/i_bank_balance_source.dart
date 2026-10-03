import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_balance_params.dart';

abstract class IBankBalanceSource<
  TBalances,
  TBigInt,
  TFundsBalance,
  TJournal,
  TUsers,
  TFunds,
  TEvents
> {
  Future<TBalances> fetchBankBalance(int bankAccountID);
  Future<TBigInt> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  });
  Future<TBigInt> calculateRemaining(List<JournalLineModel> journalLines);
  Future<TFundsBalance> fetchAllFundsBalance();
  Future<TUsers> fetchAllUsers();
  Future<TFunds> fetchAllFunds();
  Future<TEvents> fetchAllEvents();
  Future<TJournal> payTo(BankBalanceParams params);
  Future<TJournal> receiveFrom(BankBalanceParams params);
}
