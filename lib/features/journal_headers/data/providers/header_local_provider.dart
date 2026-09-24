import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/sources/i_header_source.dart';

abstract class IHeaderLocalProvider
    implements IHeaderSource<List<HeaderModel>> {}

class HeaderLocalProvider implements IHeaderLocalProvider {
  final JournalsDao _journalsDao;

  HeaderLocalProvider(this._journalsDao);

  @override
  Future<List<HeaderModel>> fetchAllHeaders() async {
    final headers = await _journalsDao.fetchAllHeaders();

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
}
