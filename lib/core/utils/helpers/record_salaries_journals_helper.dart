import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/data/params/user_salary_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

class RecordSalariesJournalsHelper {
  RecordSalariesJournalsHelper._();

  static List<JournalLinesCompanion> identificationSalaries({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) eventInfo,
    required DateTime date,
    required List<UserSalaryParams> salaryParams,
    required String series,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final salaryID =
        subsidiaryAccountsMap[SubsidiaryAccountType.salaryExpense]!.id;

    generatedJournalLines.add(
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo.accountID),
        subsidiaryId: salaryID,
        debit: salaryParams.fold<BigInt>(
          BigInt.zero,
          (sum, i) => sum + i.salary,
        ),
        credit: BigInt.zero,
        series: series,
        date: Value(date),
        memo: Value('بابت شناسایی حقوق اعضا در رویداد ${eventInfo.name}'),
      ),
    );

    for (var si in salaryParams) {
      generatedJournalLines.add(
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(si.userInfo.accountID),
          secondDetailedId: Value(eventInfo.accountID),
          subsidiaryId: payableID,
          debit: BigInt.zero,
          credit: si.salary,
          series: series,
          date: Value(date),
          memo: Value('بابت حقوق رویداد ${eventInfo.name}'),
        ),
      );
    }

    return generatedJournalLines;
  }
}
