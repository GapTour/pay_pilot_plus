import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';

abstract class IEventRegistrationsSource<TList, TInt> {
  Future<TList> fetchAllRegistrations(int eventID);
  Future<TList> registerGuests(EventRegistrationParams params);
  Future<TList> registerMembers(EventRegistrationParams params);
  Future<TInt> deleteRegistration(DeleteRegistrationParams params);
  Future<TInt> changeAbsentStatus(int registrationID, bool isAbsent);
}
