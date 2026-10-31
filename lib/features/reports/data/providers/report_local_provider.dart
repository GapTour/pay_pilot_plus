import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/accounts_chart/accounts_chart_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/features/reports/data/sources/i_report_source.dart';

abstract class IReportLocalProvider
    implements
        IReportSource<
          List<HeaderModel>,
          List<JournalLineModel>,
          List<SubsidiaryModel>,
          List<DetailedAccountModel>
        > {}

class ReportLocalProvider implements IReportLocalProvider {
  final JournalsDao _journalsDao;
  final AccountsChartDao _accountsChartDao;
  final DetailedAccountsDao _detailedAccountsDao;

  ReportLocalProvider(
    this._journalsDao,
    this._accountsChartDao,
    this._detailedAccountsDao,
  );

  @override
  Future<List<HeaderModel>> fetchHeaders({DateTime? from, DateTime? to}) async {
    final headers = await _journalsDao.fetchHeadersByDate(from: from, to: to);

    return headers.map((e) {
      return HeaderModel(
        id: e.id,
        entryDate: e.entryDate,
        entryNumber: e.entryNumber,
        type: e.type,
        description: e.description,
        createdAt: e.createdAt,
      );
    }).toList();
  }

  @override
  Future<List<JournalLineModel>> fetchLines({
    DateTime? from,
    DateTime? to,
    int? subsidiaryID,
    int? detailedID,
  }) async {
    final results = await _journalsDao.fetchJournalLinesForReport(
      from: from,
      to: to,
      subsidiaryID: subsidiaryID,
      detailedID: detailedID,
    );

    return results.map((e) {
      final line = e.journalLine;
      final subAccount = e.subAccount;
      final group = e.group;
      final general = e.general;

      final subsidiaryModel = SubsidiaryModel(
        id: subAccount.id,
        accountGroup: (id: group.id, type: group.type),
        generalAccount: (id: general.id, type: general.type),
        type: subAccount.type,
      );

      return JournalLineModel(
        id: line.id,
        headerID: line.headerId,
        subsidiaryAccount: subsidiaryModel,
        firstDetailedInfo: e.detailed1 != null
            ? _toDetailedModel(e.detailed1!)
            : null,
        secondDetailedInfo: e.detailed2 != null
            ? _toDetailedModel(e.detailed2!)
            : null,
        debit: line.debit,
        credit: line.credit,
        series: line.series,
        memo: line.memo,
        noticeMemo: line.noticeMemo,
      );
    }).toList();
  }

  @override
  Future<List<SubsidiaryModel>> fetchAllSubsidiaries() async {
    final accounts = await _accountsChartDao.fetchAllAccounts();

    final groups = {for (final g in accounts.accountGroupItems) g.id: g};
    final generals = {for (final g in accounts.generalAccountItems) g.id: g};

    return accounts.subsidiaryAccountItems.map((e) {
      final group = groups[e.accountGroupId]!;
      final general = generals[e.generalAccountId]!;

      return SubsidiaryModel(
        id: e.id,
        accountGroup: (id: group.id, type: group.type),
        generalAccount: (id: general.id, type: general.type),
        type: e.type,
      );
    }).toList();
  }

  @override
  Future<List<DetailedAccountModel>> fetchAllDetailedAccounts() async {
    final accounts = await _detailedAccountsDao.fetchAllAccounts();

    return accounts.map(_toDetailedModel).toList();
  }

  DetailedAccountModel _toDetailedModel(DetailedAccount account) {
    return DetailedAccountModel(
      id: account.id,
      code: account.code,
      name: account.name,
      type: account.type,
      isActive: account.isActive,
      userInfo: account.userID != null ? (id: account.userID!, name: '') : null,
      eventInfo: account.eventID != null
          ? (id: account.eventID!, name: '')
          : null,
      bankInfo: account.bankID != null ? (id: account.bankID!, name: '') : null,
    );
  }
}
