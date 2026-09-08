import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_source.dart';

abstract class IBankLocalProvider
    implements IBankSource<BankModel, int, List<BankModel>> {}

class BankLocalProvider implements IBankLocalProvider {
  final BanksDao _banksDao;
  final DetailedAccountsDao _accountsDao;

  BankLocalProvider(this._banksDao, this._accountsDao);

  @override
  Future<int> archiveBank(int id) async {
    final bankAccount = await _accountsDao.fetchBankAccount(id);
    await _accountsDao.archiveAccount(bankAccount.id);

    return await _banksDao.archiveBank(id);
  }

  @override
  Future<BankModel> insertBank(BankParams params) async {
    final bankID = await _banksDao.insertBank(params);

    final accountParams = DetailedAccountParams(
      id: null,
      attachmentID: bankID,
      name: params.name.trim(),
      type: .bank,
    );
    final newAccount = await _accountsDao.insertAccount(accountParams);

    return BankModel(
      bankID: bankID,
      detailedAccountID: newAccount.id,
      accountCode: newAccount.code,
      accountName: params.name.trim(),
      name: params.name.trim(),
      description: params.description,
      isActive: true,
      number: params.number,
    );
  }

  @override
  Future<BankModel> updateBank(BankParams params) async {
    await _banksDao.updateBank(params);

    final detailedAccount = await _accountsDao.fetchBankAccount(params.id!);
    final updateAccountParams = DetailedAccountParams(
      id: detailedAccount.id,
      attachmentID: detailedAccount.bankID,
      name: params.name.trim(),
      type: .bank,
      isActive: params.isActive,
    );
    await _accountsDao.updateAccount(updateAccountParams);

    return BankModel(
      bankID: params.id!,
      detailedAccountID: detailedAccount.id,
      accountCode: detailedAccount.code,
      accountName: params.name.trim(),
      name: params.name.trim(),
      description: params.description,
      isActive: true,
      number: params.number,
    );
  }

  @override
  Future<List<BankModel>> fetchAllBanks() async {
    final result = await _banksDao.fetchAllActiveBanks();

    return result.map((e) {
      final bank = e.bank;
      final account = e.account;

      return BankModel(
        bankID: bank.id,
        detailedAccountID: account.id,
        accountCode: account.code,
        accountName: account.name,
        name: bank.name,
        description: bank.description,
        isActive: bank.isActive,
        number: bank.number,
      );
    }).toList();
  }
}
