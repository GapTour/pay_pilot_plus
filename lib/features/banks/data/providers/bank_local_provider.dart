import 'package:collection/collection.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SubsidiaryAccountType;
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_opening_journals_helper.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_source.dart';

abstract class IBankLocalProvider
    implements IBankSource<BankModel, int, List<BankModel>> {}

class BankLocalProvider implements IBankLocalProvider {
  final BanksDao _banksDao;
  final DetailedAccountsDao _accountsDao;
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;

  BankLocalProvider(
    this._banksDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._journalsDao,
  );

  @override
  Future<int> archiveBank(int id) async {
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _banksDao.transaction(() async {
      final bankAccount = await _accountsDao.fetchBankAccount(id);
      await _accountsDao.archiveAccount(bankAccount.id);

      return await _banksDao.archiveBank(id);
    });
  }

  @override
  Future<BankModel> insertBank(BankParams params) async {
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _banksDao.transaction(() async {
      final bankID = await _banksDao.insertBank(params);

      final accountParams = DetailedAccountParams(
        id: null,
        attachmentID: bankID,
        name: params.name.trim(),
        type: .bank,
      );
      final newAccount = await _accountsDao.insertAccount(accountParams);

      if (params.openingBalance != null) {
        final subsidiariesMap = await _subsidiaryAccountsDao
            .fetchSubsidiaryAccounts();

        final openingJournals = RecordOpeningJournalsHelper.submitBankDeposit(
          bankInfo: (
            id: bankID,
            name: params.name.trim(),
            accountID: newAccount.id,
          ),
          subsidiaryAccountsMap: subsidiariesMap,
          openingAmount: params.openingBalance!,
        );

        await _journalsDao.insertOpeningJournal(openingJournals);
      }

      return BankModel(
        id: bankID,
        detailedAccountInfo: (
          id: newAccount.id,
          code: newAccount.code,
          name: params.name.trim(),
        ),
        name: params.name.trim(),
        description: params.description,
        openingBalance: params.openingBalance ?? BigInt.zero,
        isActive: true,
        number: params.number,
      );
    });
  }

  @override
  Future<BankModel> updateBank(BankParams params) async {
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _banksDao.transaction(() async {
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

      final subsidiariesMap = await _subsidiaryAccountsDao
          .fetchSubsidiaryAccounts();
      await _journalsDao.deleteOpeningJournals(
        subsidiaryID: subsidiariesMap[SubsidiaryAccountType.bank]!.id,
        firstDetailedId: detailedAccount.id,
      );

      if (params.openingBalance != null) {
        final openingJournals = RecordOpeningJournalsHelper.submitBankDeposit(
          bankInfo: (
            id: params.id!,
            name: params.name.trim(),
            accountID: detailedAccount.id,
          ),
          subsidiaryAccountsMap: subsidiariesMap,
          openingAmount: params.openingBalance!,
        );

        await _journalsDao.insertOpeningJournal(openingJournals);
      }

      return BankModel(
        id: params.id!,
        detailedAccountInfo: (
          id: detailedAccount.id,
          code: detailedAccount.code,
          name: detailedAccount.name,
        ),
        name: params.name.trim(),
        description: params.description,
        openingBalance: params.openingBalance ?? BigInt.zero,
        isActive: true,
        number: params.number,
      );
    });
  }

  @override
  Future<List<BankModel>> fetchAllBanks() async {
    final result = await _banksDao.fetchAllActiveBanks();
    final openingLines = await _journalsDao.fetchAllOpeningJournals();

    return result.map((e) {
      final bank = e.bank;
      final account = e.account;
      final openingInfo = openingLines?.firstWhereOrNull((e) {
        return e.firstDetailedId == account.id && e.debit != BigInt.zero;
      });

      return BankModel(
        id: bank.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        openingBalance: openingInfo?.debit ?? BigInt.zero,
        name: bank.name,
        description: bank.description,
        isActive: bank.isActive,
        number: bank.number,
      );
    }).toList();
  }
}
