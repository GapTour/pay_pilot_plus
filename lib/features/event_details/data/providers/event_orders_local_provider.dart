import 'dart:convert';

import 'package:pay_pilot_plus/core/data/models/event_order_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';
import 'package:pay_pilot_plus/core/database/daos/event_orders/event_orders_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_orders_source.dart';

abstract class IEventOrdersLocalProvider
    implements IEventOrdersSource<List<OrderModel>, OrderModel, int> {}

class EventOrdersLocalProvider extends BaseRepository
    implements IEventOrdersLocalProvider {
  final EventOrdersDao _ordersDao;

  EventOrdersLocalProvider(this._ordersDao);

  @override
  Future<OrderModel> changeOrderDeliveryStatus(int id, bool isDelivered) async {
    final result = await _ordersDao.changeOrderDeliveryStatus(id, isDelivered);
    final eventOrder = result.order;
    final user = result.user;

    return OrderModel(
      id: eventOrder.id,
      eventInfo: (id: eventOrder.eventID, name: 'No Name'),
      userInfo: (id: user.id, name: user.name),
      isDelivered: eventOrder.isDelivered,
      orders: _decodeOrders(eventOrder.menuItems),
    );
  }

  @override
  Future<int> deleteOrder(int id) async {
    return await _ordersDao.deleteOrder(id);
  }

  @override
  Future<List<OrderModel>> fetchAllOrders(int eventID) async {
    final result = await _ordersDao.fetchAllOrders(eventID);

    return result.map((e) {
      final eventOrder = e.order;
      final user = e.user;

      return OrderModel(
        id: eventOrder.id,
        eventInfo: (id: eventOrder.eventID, name: 'No Name'),
        userInfo: (id: user.id, name: user.name),
        isDelivered: eventOrder.isDelivered,
        orders: _decodeOrders(eventOrder.menuItems),
      );
    }).toList();
  }

  @override
  Future<OrderModel> insertOrder(EventOrderParams params) async {
    final orderID = await _ordersDao.insertOrder(params);

    return OrderModel(
      id: orderID,
      eventInfo: params.eventInfo,
      userInfo: params.userInfo,
      isDelivered: false,
      orders: params.menuItemIDs,
    );
  }

  @override
  Future<OrderModel> updateOrder(EventOrderParams params) async {
    final orderID = await _ordersDao.updateOrder(params);

    return OrderModel(
      id: orderID,
      eventInfo: params.eventInfo,
      userInfo: params.userInfo,
      isDelivered: false,
      orders: params.menuItemIDs,
    );
  }

  List<int> _decodeOrders(String? rawOrders) {
    final List<int> orders = [];

    if (rawOrders != null && jsonDecode(rawOrders) is List) {
      orders.addAll(List<int>.from(jsonDecode(rawOrders)));
    }

    return orders;
  }
}
