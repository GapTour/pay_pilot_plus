import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/core/data/models/salary_item_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/features/simple_reports/data/sources/i_simple_report_source.dart';

typedef AccountInfo = ({int id, String name});

abstract class ISimpleReportLocalProvider
    implements
        ISimpleReportSource<
          List<SalaryItemModel>,
          List<MemberSalarySummaryModel>,
          List<AccountInfo>,
          List<AccountInfo>
        > {}

class SimpleReportLocalProvider implements ISimpleReportLocalProvider {
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;
  final DetailedAccountsDao _detailedAccountsDao;

  SimpleReportLocalProvider(
    this._journalsDao,
    this._subsidiaryAccountsDao,
    this._detailedAccountsDao,
  );

  @override
  Future<List<SalaryItemModel>> fetchSalaries({
    DateTime? from,
    DateTime? to,
    int? memberAccountID,
    int? eventAccountID,
  }) async {
    final subsidiaries = await _subsidiaryAccountsDao.fetchSubsidiaryAccounts();

    final results = await _journalsDao.fetchSalaryLines(
      payableID: subsidiaries[SubsidiaryAccountType.accountsPayable]!.id,
      salaryExpenseID: subsidiaries[SubsidiaryAccountType.salaryExpense]!.id,
      // فقط اعضای تیم؛ میزبان‌ها و مهمان‌ها در این گزارش نمی‌آیند
      memberRole: UserAccountRole.staff,
      from: from,
      to: to,
      memberAccountID: memberAccountID,
      eventAccountID: eventAccountID,
    );

    return results.map((e) {
      final line = e.journalLine;
      final member = e.member;
      final event = e.event;

      return SalaryItemModel(
        id: line.id,
        memberInfo: (id: member.id, name: member.name, code: member.code),
        eventInfo: event == null ? null : (id: event.id, name: event.name),
        amount: line.credit,
        date: line.date,
        memo: line.memo,
      );
    }).toList();
  }

  @override
  Future<List<MemberSalarySummaryModel>> fetchMemberSalarySummaries({
    DateTime? from,
    DateTime? to,
    int? eventAccountID,
  }) async {
    final salaries = await fetchSalaries(
      from: from,
      to: to,
      eventAccountID: eventAccountID,
    );

    final itemsByMember = <int, List<SalaryItemModel>>{};
    for (final item in salaries) {
      itemsByMember.putIfAbsent(item.memberInfo.id, () => []).add(item);
    }

    final subsidiaries = await _subsidiaryAccountsDao.fetchSubsidiaryAccounts();
    final balances = await _journalsDao.fetchPayableBalances(
      payableID: subsidiaries[SubsidiaryAccountType.accountsPayable]!.id,
      memberAccountIDs: itemsByMember.keys.toList(),
    );

    final summaries = itemsByMember.entries.map((entry) {
      final items = entry.value;

      return MemberSalarySummaryModel(
        memberInfo: items.first.memberInfo,
        totalSalary: items.fold(BigInt.zero, (sum, i) => sum + i.amount),
        currentBalance: balances[entry.key] ?? BigInt.zero,
        items: items,
      );
    }).toList();

    // بیشترین حقوق در ابتدای لیست
    summaries.sort((a, b) => b.totalSalary.compareTo(a.totalSalary));

    return summaries;
  }

  @override
  Future<List<AccountInfo>> fetchEventAccounts() async {
    final accounts = await _detailedAccountsDao.fetchAllAccounts();

    return accounts
        .where((e) => e.type == DetailedAccountType.event)
        .map((e) => (id: e.id, name: e.name))
        .toList();
  }

  @override
  Future<List<AccountInfo>> fetchMemberAccounts() async {
    final accounts = await _detailedAccountsDao.fetchUserAccountsByRole(
      UserAccountRole.staff,
    );

    return accounts.map((e) => (id: e.id, name: e.name)).toList();
  }
}
