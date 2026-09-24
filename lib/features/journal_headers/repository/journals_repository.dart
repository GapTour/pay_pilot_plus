import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/providers/header_local_provider.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/providers/line_local_provider.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/sources/i_header_source.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/sources/i_line_source.dart';

abstract class IJournalsRepository
    implements
        IHeaderSource<DataState<List<HeaderModel>>>,
        ILineSource<DataState<List<JournalLineModel>>> {}

class JournalsRepository extends BaseRepository implements IJournalsRepository {
  final IHeaderLocalProvider _headerLocalProvider;
  final ILineLocalProvider _lineLocalProvider;

  JournalsRepository(this._headerLocalProvider, this._lineLocalProvider);

  @override
  Future<DataState<List<HeaderModel>>> fetchAllHeaders() {
    return safeDbCall(() => _headerLocalProvider.fetchAllHeaders());
  }

  @override
  Future<DataState<List<JournalLineModel>>> fetchAllLines(int headerID) {
    return safeDbCall(() => _lineLocalProvider.fetchAllLines(headerID));
  }
}
