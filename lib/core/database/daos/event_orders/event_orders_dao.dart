import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'event_orders_dao.g.dart';

@DriftAccessor(tables: [EventOrders])
class EventOrdersDao extends DatabaseAccessor<AppDatabase>
    with _$EventOrdersDaoMixin {
  EventOrdersDao(super.db);

  Future<List<({EventOrder order, User user})>> fetchAllOrders(
    int eventID,
  ) async {
    final rawEventOrders =
        await ((select(
              eventOrders,
            )..where((tbl) => tbl.eventID.equals(eventID))).join([
              innerJoin(users, users.id.equalsExp(eventOrders.userID)),
            ]))
            .get();

    return rawEventOrders.map((row) {
      final eventOrder = row.readTable(eventOrders);
      final user = row.readTable(users);

      return (order: eventOrder, user: user);
    }).toList();
  }

  Future<({EventOrder order, User user})> changeOrderDeliveryStatus(
    int id,
    bool isDelivered,
  ) async {
    await (update(eventOrders)..where((tbl) => tbl.id.equals(id))).write(
      EventOrdersCompanion(
        isDelivered: Value(isDelivered),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final row =
        await ((select(eventOrders)..where((tbl) => tbl.id.equals(id))).join([
          innerJoin(users, users.id.equalsExp(eventOrders.userID)),
        ])).getSingle();

    final eventOrder = row.readTable(eventOrders);
    final user = row.readTable(users);

    return (order: eventOrder, user: user);
  }

  Future<int> insertOrder(EventOrderParams params) async {
    final menuItems = jsonEncode(params.menuItemIDs);

    return await db
        .into(eventOrders)
        .insert(
          EventOrdersCompanion(
            menuItems: Value(menuItems),
            userID: Value(params.userInfo.id),
            eventID: Value(params.eventInfo.id),
          ),
        );
  }

  Future<int> updateOrder(EventOrderParams params) async {
    final menuItems = jsonEncode(params.menuItemIDs);

    return await (update(
      eventOrders,
    )..where((tbl) => tbl.id.equals(params.id!))).write(
      EventOrdersCompanion(
        menuItems: Value(menuItems),
        userID: Value(params.userInfo.id),
        eventID: Value(params.eventInfo.id),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteOrder(int id) async {
    return await (delete(eventOrders)..where((tbl) => tbl.id.equals(id))).go();
  }
}
