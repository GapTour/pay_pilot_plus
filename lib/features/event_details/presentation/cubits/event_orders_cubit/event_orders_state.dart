part of 'event_orders_cubit.dart';

enum OrderFetchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == OrderFetchStatus.initial;
  bool get isLoading => this == OrderFetchStatus.loading;
  bool get isSuccess => this == OrderFetchStatus.success;
  bool get isFailure => this == OrderFetchStatus.failure;
}

enum OrderModificationStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == OrderModificationStatus.initial;
  bool get isLoading => this == OrderModificationStatus.loading;
  bool get isSuccess => this == OrderModificationStatus.success;
  bool get isFailure => this == OrderModificationStatus.failure;
}

class EventOrdersState extends Equatable {
  final OrderFetchStatus orderFetchStatus;
  final OrderModificationStatus orderModificationStatus;
  final List<OrderModel> orders;
  final List<OrderModel> allOrders;
  const EventOrdersState({
    required this.orderFetchStatus,
    required this.orderModificationStatus,
    required this.orders,
    required this.allOrders,
  });

  @override
  List<Object> get props => [
    orderFetchStatus,
    orderModificationStatus,
    orders,
    allOrders,
  ];

  EventOrdersState copyWith({
    OrderFetchStatus? orderFetchStatus,
    OrderModificationStatus? orderModificationStatus,
    List<OrderModel>? orders,
    List<OrderModel>? allOrders,
  }) {
    return EventOrdersState(
      orderFetchStatus: orderFetchStatus ?? this.orderFetchStatus,
      orderModificationStatus:
          orderModificationStatus ?? this.orderModificationStatus,
      orders: orders ?? this.orders,
      allOrders: allOrders ?? this.allOrders,
    );
  }
}
