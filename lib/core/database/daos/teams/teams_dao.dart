import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/team_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'teams_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamsDao extends DatabaseAccessor<AppDatabase> with _$TeamsDaoMixin {
  TeamsDao(super.db);

  Future<int> insertTeam(TeamParams params) async {
    return await transaction(() async {
      return await db
          .into(teams)
          .insert(
            TeamsCompanion(
              title: Value(params.title),
              description: Value(params.description),
            ),
          );
    });
  }

  Future<List<Team>> fetchAllActiveTeams() async {
    return await (db.select(
      teams,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  Future<Team> fetchTeam(int id) async {
    return await (db.select(
      teams,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateTeam(TeamParams params) async {
    return await transaction(() async {
      return await (db.update(
        teams,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        TeamsCompanion(
          title: Value(params.title),
          description: Value(params.description),
          isActive: Value(params.isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> archiveTeam(int id) async {
    return await transaction(() async {
      return await (db.update(teams)..where((tbl) => tbl.id.equals(id))).write(
        TeamsCompanion(
          isActive: Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }
}
