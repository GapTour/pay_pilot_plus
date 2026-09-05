import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_partner_shares_dao.g.dart';

@DriftAccessor(tables: [Users, Events, Teams, TeamMembers, EventPartnerShares])
class EventPartnerSharesDao extends DatabaseAccessor<AppDatabase>
    with _$EventPartnerSharesDaoMixin {
  EventPartnerSharesDao(super.db);

  Future<int> insertPartnerShare(EventPartnerShareParams params) async {
    return await transaction(() async {
      return await into(eventPartnerShares).insert(
        EventPartnerSharesCompanion(
          sharePercentage: Value(params.usersInfo.first.ratio),
          eventID: Value(params.eventInfo.id),
          userID: Value(params.usersInfo.first.id),
        ),
      );
    });
  }

  Future<void> insertMultiPartnerShare(EventPartnerShareParams params) async {
    return await transaction(() async {
      return await batch((batch) {
        batch.insertAll(
          eventPartnerShares,
          params.usersInfo.map((row) {
            return EventPartnerSharesCompanion.insert(
              sharePercentage: row.ratio,
              eventID: params.eventInfo.id,
              userID: row.id,
            );
          }),
        );
      });
    });
  }

  Future<List<({EventPartnerShare partnerShare, User user})>>
  fetchAllPartnerShares(int eventID) async {
    final query =
        (select(
          eventPartnerShares,
        )..where((tbl) => tbl.eventID.equals(eventID))).join([
          innerJoin(users, users.id.equalsExp(eventPartnerShares.userID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final shares = row.readTable(eventPartnerShares);
      final user = row.readTable(users);

      return (partnerShare: shares, user: user);
    }).toList();
  }

  Future<int> updateRatio(EventPartnerShareParams params) async {
    return await transaction(() async {
      return await (update(
        eventPartnerShares,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        EventPartnerSharesCompanion(
          sharePercentage: Value(params.usersInfo.first.ratio),
        ),
      );
    });
  }

  Future<int> deleteRatio(int id) async {
    return await transaction(() async {
      return await (delete(
        eventPartnerShares,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int> deleteAllPartnerSharesByEvent(int eventID) async {
    return await transaction(() async {
      return await (db.delete(
        eventPartnerShares,
      )..where((tbl) => tbl.eventID.equals(eventID))).go();
    });
  }
}
