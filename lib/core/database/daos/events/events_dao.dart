import 'package:drift/drift.dart';
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
          entranceFee: Value(params.entranceFee),
          snacksFee: Value(params.snacksFee),
          userID: Value(params.userInfo.id),
          date: Value(params.date),
        ),
      );
    });
  }

  Future<List<({Event event, DetailedAccount account, Team team, User user})>>
  fetchAllActiveEvents() async {
    final query = select(detailedAccounts).join([
      innerJoin(
        events,
        events.id.equalsExp(detailedAccounts.eventID) &
            events.isActive.equals(true),
      ),
    ]);
    final allTeams = await select(teams).get();
    final allUsers = await select(users).get();

    final rows = await query.get();

    return rows.map((row) {
      final event = row.readTable(events);
      final account = row.readTable(detailedAccounts);
      final team = allTeams.firstWhere((tbl) => tbl.id == event.teamID);
      final user = allUsers.firstWhere((tbl) => tbl.id == event.userID);

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
          entranceFee: Value(params.entranceFee),
          snacksFee: Value(params.snacksFee),
          userID: Value(params.userInfo.id),
          date: Value(params.date),
        ),
      );
    });
  }

  Future<int> closeEvent(int id) async {
    return await transaction(() async {
      return await (update(events)..where((tbl) => tbl.id.equals(id))).write(
        EventsCompanion(isClosed: Value(true)),
      );
    });
  }

  Future<int> openEvent(int id) async {
    return await transaction(() async {
      return await (update(events)..where((tbl) => tbl.id.equals(id))).write(
        EventsCompanion(isClosed: Value(false)),
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

  // Future<void> deleteEvent(int id) async {
  //   await (db.delete(events)..where((tbl) => tbl.id.equals(id))).go();
  // }
}
