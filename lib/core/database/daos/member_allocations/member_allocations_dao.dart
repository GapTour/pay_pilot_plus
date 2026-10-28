import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'member_allocations_dao.g.dart';

@DriftAccessor(tables: [MemberAllocations, Users])
class MemberAllocationsDao extends DatabaseAccessor<AppDatabase>
    with _$MemberAllocationsDaoMixin {
  MemberAllocationsDao(super.db);

  Future<int> insertMemberRatio(MemberAllocationParams params) async {
    return await transaction(() async {
      return await into(memberAllocations).insert(
        MemberAllocationsCompanion(
          sharePercentage: Value(params.usersInfo.first.ratio),
          eventID: Value(params.eventInfo.id),
          userID: Value(params.usersInfo.first.id),
        ),
      );
    });
  }

  Future<void> insertMultiMemberRatio(MemberAllocationParams params) async {
    return await transaction(() async {
      return await batch((batch) {
        batch.insertAll(
          memberAllocations,
          params.usersInfo.map((row) {
            return MemberAllocationsCompanion.insert(
              sharePercentage: row.ratio,
              eventID: params.eventInfo.id,
              userID: row.id,
            );
          }),
        );
      });
    });
  }

  Future<List<({MemberAllocation memberAllocation, User user})>>
  fetchAllMemberRatios(int eventID) async {
    final query =
        (select(
          memberAllocations,
        )..where((tbl) => tbl.eventID.equals(eventID))).join([
          innerJoin(users, users.id.equalsExp(memberAllocations.userID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final memberAllocation = row.readTable(memberAllocations);
      final user = row.readTable(users);

      return (memberAllocation: memberAllocation, user: user);
    }).toList();
  }

  Future<int> updateMemberRatio(MemberAllocationParams params) async {
    return await transaction(() async {
      return await (update(
        memberAllocations,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        MemberAllocationsCompanion(
          sharePercentage: Value(params.usersInfo.first.ratio),
        ),
      );
    });
  }

  Future<int> deleteMemberRatio(int id) async {
    return await transaction(() async {
      return await (delete(
        memberAllocations,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int> deleteAllMemberRatiosByEvent(int eventID) async {
    return await transaction(() async {
      return await (db.delete(
        memberAllocations,
      )..where((tbl) => tbl.eventID.equals(eventID))).go();
    });
  }
}
