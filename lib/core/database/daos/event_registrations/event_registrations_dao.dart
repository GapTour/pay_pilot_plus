import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_registrations_dao.g.dart';

@DriftAccessor(tables: [EventRegistrations, Users, DetailedAccounts])
class EventRegistrationsDao extends DatabaseAccessor<AppDatabase>
    with _$EventRegistrationsDaoMixin {
  EventRegistrationsDao(super.db);

  Future<void> insertRegistration(EventRegistrationParams params) async {
    return await transaction(() async {
      return await batch((batch) {
        batch.insertAll(
          eventRegistrations,
          params.guestsInfo.map((row) {
            return EventRegistrationsCompanion.insert(
              eventID: params.eventInfo.id,
              userID: row.id,
              grossAmount: params.grossAmount,
              discountAmount: params.discountAmount,
              netAmount: params.netAmount,
              status: Value(params.status),
              description: Value(params.description),
              wasAbsent: Value(true),
            );
          }),
        );
      });
    });
  }

  Future<int> updateRegistration(EventRegistrationParams params) async {
    return await transaction(() async {
      return await (update(
        eventRegistrations,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        EventRegistrationsCompanion(
          status: Value(params.status),
          grossAmount: Value(params.grossAmount),
          discountAmount: Value(params.discountAmount),
          netAmount: Value(params.netAmount),
          userID: Value(params.guestsInfo.first.id),
          description: Value(params.description),
        ),
      );
    });
  }

  Future<int> changeAbsentStatus(int registrationID, bool isAbsent) async {
    return await transaction(() async {
      return await (update(eventRegistrations)
            ..where((tbl) => tbl.id.equals(registrationID)))
          .write(EventRegistrationsCompanion(wasAbsent: Value(isAbsent)));
    });
  }

  Future<
    List<
      ({EventRegistration registration, User user, DetailedAccount userAccount})
    >
  >
  fetchAllRegistrations(int eventID) async {
    final query =
        (select(
          eventRegistrations,
        )..where((tbl) => tbl.eventID.equals(eventID))).join([
          innerJoin(users, users.id.equalsExp(eventRegistrations.userID)),
          innerJoin(
            detailedAccounts,
            detailedAccounts.userID.equalsExp(eventRegistrations.userID),
          ),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final registration = row.readTable(eventRegistrations);
      final user = row.readTable(users);
      final userAccount = row.readTable(detailedAccounts);

      return (registration: registration, user: user, userAccount: userAccount);
    }).toList();
  }

  Future<int> changeStatus(int id, RegistrationStatus status) async {
    return await transaction(() async {
      return await (update(eventRegistrations)
            ..where((tbl) => tbl.id.equals(id)))
          .write(EventRegistrationsCompanion(status: Value(status)));
    });
  }

  Future<void> deleteRegistration(int id) async {
    return await transaction(() async {
      await (db.delete(
        eventRegistrations,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }
}
