import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';

abstract class IEventOrdersSource<TList, TOrder, TInt> {
  Future<TOrder> insertOrder(EventOrderParams params);
  Future<TInt> deleteOrder(int id);
  Future<TOrder> changeOrderDeliveryStatus(int id, bool isDelivered);
  Future<TList> fetchAllOrders(int eventID);
  Future<TOrder> updateOrder(EventOrderParams params);
}
