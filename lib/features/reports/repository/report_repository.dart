import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/reports/data/providers/report_local_provider.dart';
import 'package:pay_pilot_plus/features/reports/data/sources/i_report_source.dart';

abstract class IReportRepository
    implements
        IReportSource<
          DataState<List<HeaderModel>>,
          DataState<List<JournalLineModel>>,
          DataState<List<SubsidiaryModel>>,
          DataState<List<DetailedAccountModel>>
        > {}

class ReportRepository extends BaseRepository implements IReportRepository {
  final IReportLocalProvider _reportLocalProvider;

  ReportRepository(this._reportLocalProvider);

  @override
  Future<DataState<List<HeaderModel>>> fetchHeaders({
    DateTime? from,
    DateTime? to,
  }) {
    return safeDbCall(
      () => _reportLocalProvider.fetchHeaders(from: from, to: to),
    );
  }

  @override
  Future<DataState<List<JournalLineModel>>> fetchLines({
    DateTime? from,
    DateTime? to,
    int? subsidiaryID,
    int? detailedID,
  }) {
    return safeDbCall(
      () => _reportLocalProvider.fetchLines(
        from: from,
        to: to,
        subsidiaryID: subsidiaryID,
        detailedID: detailedID,
      ),
    );
  }

  @override
  Future<DataState<List<SubsidiaryModel>>> fetchAllSubsidiaries() {
    return safeDbCall(() => _reportLocalProvider.fetchAllSubsidiaries());
  }

  @override
  Future<DataState<List<DetailedAccountModel>>> fetchAllDetailedAccounts() {
    return safeDbCall(() => _reportLocalProvider.fetchAllDetailedAccounts());
  }
}
