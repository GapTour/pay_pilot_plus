import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/events/data/providers/event_local_provider.dart';
import 'package:pay_pilot_plus/features/events/data/sources/i_event_source.dart';

abstract class IEventRepository
    implements
        IEventSource<
          DataState<EventModel>,
          DataState<int>,
          DataState<List<EventModel>>,
          DataState<List<TeamModel>>,
          DataState<List<UserModel>>
        > {}

class EventRepository extends BaseRepository implements IEventRepository {
  final IEventLocalProvider _localProvider;

  EventRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveEvent(int id) {
    return safeDbCall(() => _localProvider.archiveEvent(id));
  }

  @override
  Future<DataState<int>> closeEvent(EventParams params) {
    return safeDbCall(() => _localProvider.closeEvent(params));
  }

  @override
  Future<DataState<List<EventModel>>> fetchAllEvents() {
    return safeDbCall(() => _localProvider.fetchAllEvents());
  }

  @override
  Future<DataState<List<TeamModel>>> fetchAllTeams() {
    return safeDbCall(() => _localProvider.fetchAllTeams());
  }

  @override
  Future<DataState<EventModel>> insertEvent(EventParams params) {
    return safeDbCall(() => _localProvider.insertEvent(params));
  }

  @override
  Future<DataState<int>> openEvent(int id) {
    return safeDbCall(() => _localProvider.openEvent(id));
  }

  @override
  Future<DataState<EventModel>> updateEvent(EventParams params) {
    return safeDbCall(() => _localProvider.updateEvent(params));
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllHosts() {
    return safeDbCall(() => _localProvider.fetchAllHosts());
  }
}
