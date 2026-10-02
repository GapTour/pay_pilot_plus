import 'package:pay_pilot_plus/core/data/params/close_event_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';

abstract class IEventSource<TEvent, TInt, TList, TTeams, TUsers, TInts> {
  Future<TEvent> insertEvent(EventParams params);
  Future<TInt> archiveEvent(int id);
  Future<TInt> closeEvent(CloseEventParams params);
  Future<TInt> openEvent(int id);
  Future<TInts> fetchRegisteredGuestsID(int eventID);
  Future<TList> fetchAllEvents();
  Future<TTeams> fetchAllTeams();
  Future<TUsers> fetchAllHosts();
  Future<TUsers> fetchAllUsers();
  Future<TEvent> updateEvent(EventParams params);
}
