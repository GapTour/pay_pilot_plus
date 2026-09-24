import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_entrance_fee_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_entrance_fees_dao.g.dart';

@DriftAccessor(tables: [EventEntranceFees, Users, Events, Banks])
class EventEntranceFeesDao extends DatabaseAccessor<AppDatabase>
    with _$EventEntranceFeesDaoMixin {
  EventEntranceFeesDao(super.db);

  Future<int> insertEntranceFee(EventEntranceFeeParams params) async {
    final staffIDs = params.staffsInfo.isEmpty
        ? ''
        : jsonEncode(params.staffsInfo.map((e) => e.id).toSet());

    return await transaction(() async {
      return await into(eventEntranceFees).insert(
        EventEntranceFeesCompanion(
          eventID: Value(params.eventInfo.id),
          bankID: Value(params.bankInfo.id),
          hostID: Value(params.hostInfo.id),
          staffIDs: Value(staffIDs),
          entranceFee: Value(params.entranceFee),
          snacksFee: Value(params.snacksFee),
          paidAt: Value(params.paidAt),
          totalExpenseAmount: Value(params.totalExpenseAmount),
          totalGuests: Value(params.totalGuests),
          description: Value(params.description),
        ),
      );
    });
  }

  Future<int> updateEntranceFee(EventEntranceFeeParams params) async {
    final staffIDs = params.staffsInfo.isEmpty
        ? ''
        : jsonEncode(params.staffsInfo.map((e) => e.id).toSet());

    return await transaction(() async {
      return await (update(
        eventEntranceFees,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        EventEntranceFeesCompanion(
          eventID: Value(params.eventInfo.id),
          bankID: Value(params.bankInfo.id),
          hostID: Value(params.hostInfo.id),
          staffIDs: Value(staffIDs),
          entranceFee: Value(params.entranceFee),
          snacksFee: Value(params.snacksFee),
          paidAt: Value(params.paidAt),
          totalExpenseAmount: Value(params.totalExpenseAmount),
          totalGuests: Value(params.totalGuests),
          description: Value(params.description),
        ),
      );
    });
  }

  Future<
    ({
      EventEntranceFee entranceFee,
      User host,
      Event event,
      Bank bank,
      List<User> staffs,
    })?
  >
  fetchEntranceFeeInfo(int eventID) async {
    final query =
        (select(
          eventEntranceFees,
        )..where((tbl) => tbl.eventID.equals(eventID))).join([
          innerJoin(users, users.id.equalsExp(eventEntranceFees.hostID)),
          innerJoin(banks, banks.id.equalsExp(eventEntranceFees.bankID)),
          innerJoin(events, events.id.equalsExp(eventEntranceFees.eventID)),
        ]);

    final row = await query.getSingleOrNull();

    if (row == null) return null;

    final staffs = await (select(
      users,
    )..where((tbl) => tbl.role.equals(UserAccountRole.staff.name))).get();

    final entranceFee = row.readTable(eventEntranceFees);
    final host = row.readTable(users);
    final bank = row.readTable(banks);
    final event = row.readTable(events);

    return (
      entranceFee: entranceFee,
      host: host,
      event: event,
      bank: bank,
      staffs: staffs,
    );
  }

  Future<int> deleteEntranceFee(int eventID) async {
    return await transaction(() async {
      return await (delete(
        eventEntranceFees,
      )..where((tbl) => tbl.eventID.equals(eventID))).go();
    });
  }
}
