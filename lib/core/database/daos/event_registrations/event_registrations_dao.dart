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
              registeredAt: Value(params.registeredAt),
              snacksAssignmentFundID:
                  params.snacksAssignmentStatus?.isAssignmentToFund == true
                  ? Value(params.snacksAssignmentInfo!.id)
                  : const Value.absent(),
              snacksAssignmentUserID:
                  params.snacksAssignmentStatus?.isAssignmentToStaff == true
                  ? Value(params.snacksAssignmentInfo!.id)
                  : const Value.absent(),
              snacksFeeAssignmentStatus: Value(
                params.snacksAssignmentStatus ??
                    SnacksFeeAssignmentStatus.unassign,
              ),
            );
          }),
        );
      });
    });
  }

  // Future<int> updateRegistration(EventRegistrationParams params) async {
  //   return await transaction(() async {
  //     return await (update(
  //       eventRegistrations,
  //     )..where((tbl) => tbl.id.equals(params.id!))).write(
  //       EventRegistrationsCompanion(
  //         status: Value(params.status),
  //         grossAmount: Value(params.grossAmount),
  //         discountAmount: Value(params.discountAmount),
  //         netAmount: Value(params.netAmount),
  //         userID: Value(params.guestsInfo.first.id),
  //         description: Value(params.description),
  //         snacksFeeAssignmentStatus: Value(
  //           params.snacksAssignmentStatus ?? SnacksFeeAssignmentStatus.unassign,
  //         ),
  //       ),
  //     );
  //   });
  // }

  Future<int> changeAbsentStatus(int registrationID, bool isAbsent) async {
    return await transaction(() async {
      return await (update(eventRegistrations)
            ..where((tbl) => tbl.id.equals(registrationID)))
          .write(EventRegistrationsCompanion(wasAbsent: Value(isAbsent)));
    });
  }

  Future<
    List<
      ({
        EventRegistration registration,
        User guest,
        DetailedAccount userAccount,
        Event event,
        User? snacksAssignmentUser,
        Fund? snacksAssignmentFund,
      })
    >
  >
  fetchAllRegistrations(int eventID) async {
    final guestUser = alias(users, 'guest_user');
    final snacksUser = alias(users, 'snacks_user');

    final query = select(eventRegistrations).join([
      innerJoin(guestUser, guestUser.id.equalsExp(eventRegistrations.userID)),
      innerJoin(
        detailedAccounts,
        detailedAccounts.userID.equalsExp(eventRegistrations.userID),
      ),
      innerJoin(events, events.id.equalsExp(eventRegistrations.eventID)),
      leftOuterJoin(
        snacksUser,
        snacksUser.id.equalsExp(eventRegistrations.snacksAssignmentUserID),
      ),
      leftOuterJoin(
        funds,
        funds.id.equalsExp(eventRegistrations.snacksAssignmentFundID),
      ),
    ])..where(eventRegistrations.eventID.equals(eventID));

    return await query.map((row) {
      return (
        registration: row.readTable(eventRegistrations),
        guest: row.readTable(guestUser),
        userAccount: row.readTable(detailedAccounts),
        event: row.readTable(events),
        snacksAssignmentUser: row.readTableOrNull(snacksUser),
        snacksAssignmentFund: row.readTableOrNull(funds),
      );
    }).get();
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
