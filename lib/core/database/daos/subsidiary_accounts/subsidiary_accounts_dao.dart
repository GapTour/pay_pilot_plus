import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'subsidiary_accounts_dao.g.dart';

@DriftAccessor(tables: [SubsidiaryAccounts])
class SubsidiaryAccountsDao extends DatabaseAccessor<AppDatabase>
    with _$SubsidiaryAccountsDaoMixin {
  SubsidiaryAccountsDao(super.db);

  Future<Map<SubsidiaryAccountType, SubsidiaryAccount>>
  fetchSubsidiaryAccounts() async {
    final accounts = await select(subsidiaryAccounts).get();
    final mapAccounts = <SubsidiaryAccountType, SubsidiaryAccount>{};

    for (var a in accounts) {
      mapAccounts[a.type] = a;
    }

    return mapAccounts;
  }

  Future<SubsidiaryAccount> fetchSubsidiaryAccount(
    SubsidiaryAccountType type,
  ) async {
    return await (select(
      subsidiaryAccounts,
    )..where((tbl) => tbl.type.equals(type.name))).getSingle();
  }
}
