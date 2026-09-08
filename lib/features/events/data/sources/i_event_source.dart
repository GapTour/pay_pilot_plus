import 'package:pay_pilot_plus/core/data/params/event_params.dart';

abstract class IEventSource<TEvent, TInt, TList, TTeams> {
  Future<TEvent> insertEvent(EventParams params);
  Future<TInt> archiveEvent(int id);
  Future<TInt> closeEvent(EventParams params);
  Future<TInt> openEvent(int id);
  Future<TList> fetchAllEvents();
  Future<TTeams> fetchAllTeams();
  Future<TEvent> updateEvent(EventParams params);
}
