import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_ads_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_ads_dao.g.dart';

@DriftAccessor(tables: [EventAds, Users, Events, Banks])
class EventAdsDao extends DatabaseAccessor<AppDatabase>
    with _$EventAdsDaoMixin {
  EventAdsDao(super.db);

  Future<int> insertAds(EventAdsParams params) async {
    if (params.bankInfo == null && params.staffInfo == null) {
      return throw StateError('اطلاعات طرف حساب نمی تواند خالی باشد!');
    }

    return await transaction(() async {
      return await into(eventAds).insert(
        EventAdsCompanion(
          eventID: Value(params.eventInfo.id),
          bankID: Value(params.bankInfo?.id),
          staffID: Value(params.staffInfo?.id),
          paidAt: Value(params.paidAt),
          adsAmount: Value(params.adsAmount),
          description: Value(params.description),
        ),
      );
    });
  }

  Future<int> updateAds(EventAdsParams params) async {
    return await transaction(() async {
      return await (update(
        eventAds,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        EventAdsCompanion(
          eventID: Value(params.eventInfo.id),
          bankID: Value(params.bankInfo?.id),
          staffID: Value(params.staffInfo?.id),
          paidAt: Value(params.paidAt),
          adsAmount: Value(params.adsAmount),
          description: Value(params.description),
        ),
      );
    });
  }

  Future<List<({EventAd eventAd, User? staff, Event event, Bank? bank})>>
  fetchAllAds(int eventID) async {
    final query =
        (select(eventAds)..where((tbl) => tbl.eventID.equals(eventID))).join([
          leftOuterJoin(users, users.id.equalsExp(eventAds.staffID)),
          leftOuterJoin(banks, banks.id.equalsExp(eventAds.bankID)),
          innerJoin(events, events.id.equalsExp(eventAds.eventID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final eventAd = row.readTable(eventAds);
      final staff = row.readTableOrNull(users);
      final bank = row.readTableOrNull(banks);
      final event = row.readTable(events);

      return (eventAd: eventAd, staff: staff, event: event, bank: bank);
    }).toList();
  }

  Future<int> deleteAds(int id) async {
    return await transaction(() async {
      return await (delete(eventAds)..where((tbl) => tbl.id.equals(id))).go();
    });
  }
}
