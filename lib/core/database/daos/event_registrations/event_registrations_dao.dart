import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_registrations_dao.g.dart';

@DriftAccessor(
  tables: [EventRegistrations, Events, Users, DetailedAccounts, Funds, Teams],
)
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

  /// همه ثبت‌نام‌های یک کاربر همراه با اطلاعات کامل رویداد، جدیدترین اول
  Future<
    List<
      ({
        EventRegistration registration,
        Event event,
        DetailedAccount eventAccount,
        Team team,
        User host,
      })
    >
  >
  fetchUserRegistrations(int userID) async {
    final host = alias(users, 'host_user');

    final query =
        (select(
            eventRegistrations,
          )..where((tbl) => tbl.userID.equals(userID))).join([
            innerJoin(events, events.id.equalsExp(eventRegistrations.eventID)),
            innerJoin(
              detailedAccounts,
              detailedAccounts.eventID.equalsExp(events.id),
            ),
            innerJoin(teams, teams.id.equalsExp(events.teamID)),
            innerJoin(host, host.id.equalsExp(events.userID)),
          ])
          ..orderBy([
            OrderingTerm.desc(events.date),
            OrderingTerm.desc(eventRegistrations.id),
          ]);

    return await query.map((row) {
      return (
        registration: row.readTable(eventRegistrations),
        event: row.readTable(events),
        eventAccount: row.readTable(detailedAccounts),
        team: row.readTable(teams),
        host: row.readTable(host),
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
