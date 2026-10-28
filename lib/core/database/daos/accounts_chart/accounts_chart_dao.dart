import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'accounts_chart_dao.g.dart';

@DriftAccessor(tables: [AccountGroups, GeneralAccounts, SubsidiaryAccounts])
class AccountsChartDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsChartDaoMixin {
  AccountsChartDao(super.db);

  Future<
    ({
      List<AccountGroup> accountGroupItems,
      List<GeneralAccount> generalAccountItems,
      List<SubsidiaryAccount> subsidiaryAccountItems,
    })
  >
  fetchAllAccounts() async {
    final accountGroupItems = await select(accountGroups).get();
    final generalAccountItems = await select(generalAccounts).get();
    final subsidiaryAccountItems = await select(subsidiaryAccounts).get();

    return (
      accountGroupItems: accountGroupItems,
      generalAccountItems: generalAccountItems,
      subsidiaryAccountItems: subsidiaryAccountItems,
    );
  }
}
