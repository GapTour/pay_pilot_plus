import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/core/data/models/salary_item_model.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/simple_reports/data/providers/simple_report_local_provider.dart';
import 'package:pay_pilot_plus/features/simple_reports/data/sources/i_simple_report_source.dart';

abstract class ISimpleReportRepository
    implements
        ISimpleReportSource<
          DataState<List<SalaryItemModel>>,
          DataState<List<MemberSalarySummaryModel>>,
          DataState<List<AccountInfo>>,
          DataState<List<AccountInfo>>
        > {}

class SimpleReportRepository extends BaseRepository
    implements ISimpleReportRepository {
  final ISimpleReportLocalProvider _simpleReportLocalProvider;

  SimpleReportRepository(this._simpleReportLocalProvider);

  @override
  Future<DataState<List<SalaryItemModel>>> fetchSalaries({
    DateTime? from,
    DateTime? to,
    int? memberAccountID,
    int? eventAccountID,
  }) {
    return safeDbCall(
      () => _simpleReportLocalProvider.fetchSalaries(
        from: from,
        to: to,
        memberAccountID: memberAccountID,
        eventAccountID: eventAccountID,
      ),
    );
  }

  @override
  Future<DataState<List<MemberSalarySummaryModel>>> fetchMemberSalarySummaries({
    DateTime? from,
    DateTime? to,
    int? eventAccountID,
  }) {
    return safeDbCall(
      () => _simpleReportLocalProvider.fetchMemberSalarySummaries(
        from: from,
        to: to,
        eventAccountID: eventAccountID,
      ),
    );
  }

  @override
  Future<DataState<List<AccountInfo>>> fetchEventAccounts() {
    return safeDbCall(() => _simpleReportLocalProvider.fetchEventAccounts());
  }

  @override
  Future<DataState<List<AccountInfo>>> fetchMemberAccounts() {
    return safeDbCall(() => _simpleReportLocalProvider.fetchMemberAccounts());
  }
}
