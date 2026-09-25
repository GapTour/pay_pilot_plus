import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/calculate_sum_on_background_thread.dart';
import 'package:pay_pilot_plus/features/hosts/data/sources/i_host_balance_source.dart';

abstract class IHostBalanceLocalProvider
    implements IHostBalanceSource<List<JournalLineModel>, BigInt> {}

class HostBalanceLocalProvider implements IHostBalanceLocalProvider {
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;

  HostBalanceLocalProvider(this._subsidiaryAccountsDao, this._journalsDao);

  @override
  Future<List<JournalLineModel>> fetchHostBalance(int hostAccountID) async {
    final hostSubsidiaryAccount = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccount(.accountsPayable);

    final journalLines = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: hostSubsidiaryAccount.id,
      firstDetailedID: hostAccountID,
    );

    return journalLines.map((e) {
      final line = e.journalLine;
      final subAccount = e.subAccount;
      final group = e.group;
      final general = e.general;

      final detailed1 = e.detailed1;
      final detailed2 = e.detailed2;

      final subsidiaryModel = SubsidiaryModel(
        id: subAccount.id,
        accountGroup: (id: group.id, type: group.type),
        generalAccount: (id: general.id, type: general.type),
        type: subAccount.type,
      );

      DetailedAccountModel? firstDetailedModel;
      if (detailed1 != null) {
        firstDetailedModel = DetailedAccountModel(
          id: detailed1.id,
          code: detailed1.code,
          name: detailed1.name,
          type: detailed1.type,
          isActive: detailed1.isActive,
          userInfo: detailed1.userID != null
              ? (id: detailed1.userID!, name: '')
              : null,
          eventInfo: detailed1.eventID != null
              ? (id: detailed1.eventID!, name: '')
              : null,
          bankInfo: detailed1.bankID != null
              ? (id: detailed1.bankID!, name: '')
              : null,
        );
      }

      DetailedAccountModel? secondDetailedModel;
      if (detailed2 != null) {
        secondDetailedModel = DetailedAccountModel(
          id: detailed2.id,
          code: detailed2.code,
          name: detailed2.name,
          type: detailed2.type,
          isActive: detailed2.isActive,
          userInfo: detailed2.userID != null
              ? (id: detailed2.userID!, name: '')
              : null,
          eventInfo: detailed2.eventID != null
              ? (id: detailed2.eventID!, name: '')
              : null,
          bankInfo: detailed2.bankID != null
              ? (id: detailed2.bankID!, name: '')
              : null,
        );
      }

      return JournalLineModel(
        id: line.id,
        headerID: line.headerId,
        subsidiaryAccount: subsidiaryModel,
        firstDetailedInfo: firstDetailedModel,
        secondDetailedInfo: secondDetailedModel,
        debit: line.debit,
        credit: line.credit,
        series: line.series,
        memo: line.memo,
      );
    }).toList();
  }

  @override
  Future<BigInt> calculateRemaining(List<JournalLineModel> journalLines) async {
    final debitSets = journalLines.map((e) => e.debit).toSet();
    final debitAmounts = await calculateSumOnBackgroundThread(debitSets);

    final creditSets = journalLines.map((e) => e.credit).toSet();
    final creditAmounts = await calculateSumOnBackgroundThread(creditSets);

    return debitAmounts - creditAmounts;
  }
}
