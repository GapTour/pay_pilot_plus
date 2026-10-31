import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/close_event_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'events_dao.g.dart';

@DriftAccessor(tables: [Events, Teams, DetailedAccounts, Users])
class EventsDao extends DatabaseAccessor<AppDatabase> with _$EventsDaoMixin {
  EventsDao(super.db);

  Future<int> insertEvent(EventParams params) async {
    return await transaction(() async {
      return await into(events).insert(
        EventsCompanion(
          title: Value(params.title),
          teamID: Value(params.teamInfo.id),
          userID: Value(params.hostInfo.id),
          date: Value(params.date),
          entranceFee: Value(BigInt.zero),
          snacksFee: Value(BigInt.zero),
        ),
      );
    });
  }

  Future<List<({Event event, DetailedAccount account, Team team, User user})>>
  fetchAllActiveEvents() async {
    final query = (select(events)..where((tbl) => tbl.isActive.equals(true)))
        .join([
          innerJoin(
            detailedAccounts,
            detailedAccounts.eventID.equalsExp(events.id),
          ),
          innerJoin(teams, teams.id.equalsExp(events.teamID)),
          innerJoin(users, users.id.equalsExp(events.userID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final event = row.readTable(events);
      final account = row.readTable(detailedAccounts);
      final team = row.readTable(teams);
      final user = row.readTable(users);

      return (event: event, account: account, team: team, user: user);
    }).toList();
  }

  Future<Event> fetchEvent(int id) async {
    return await (select(
      events,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateEvent(EventParams params) async {
    return await transaction(() async {
      return await (update(
        events,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        EventsCompanion(
          title: Value(params.title),
          teamID: Value(params.teamInfo.id),
          userID: Value(params.hostInfo.id),
          date: Value(params.date),
        ),
      );
    });
  }

  Future<int> closeEvent(CloseEventParams params) async {
    return await transaction(() async {
      return await (update(
        events,
      )..where((tbl) => tbl.id.equals(params.id))).write(
        EventsCompanion(
          isClosed: Value(true),
          entranceFee: Value(params.entranceFee),
          snacksFee: Value(params.snacksFee),
        ),
      );
    });
  }

  Future<int> openEvent(int id) async {
    return await transaction(() async {
      return await (update(events)..where((tbl) => tbl.id.equals(id))).write(
        EventsCompanion(
          isClosed: Value(false),
          entranceFee: Value(BigInt.zero),
          snacksFee: Value(BigInt.zero),
        ),
      );
    });
  }

  Future<int> archiveEvent(int id) async {
    return await transaction(() async {
      return await (update(events)..where((tbl) => tbl.id.equals(id))).write(
        EventsCompanion(isActive: Value(false)),
      );
    });
  }
}
