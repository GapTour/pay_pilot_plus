import 'package:pay_pilot_plus/core/data/params/bank_params.dart';

abstract class IBankSource<TBank, TInt, TList> {
  Future<TBank> insertBank(BankParams params);
  Future<TInt> archiveBank(int id);
  Future<TList> fetchAllBanks();
  Future<TBank> updateBank(BankParams params);
}
