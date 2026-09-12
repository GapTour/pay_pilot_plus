import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_order_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_orders_state.dart';

class EventOrdersCubit extends Cubit<EventOrdersState> {
  final IEventDetailsRepository _repository;

  EventOrdersCubit(this._repository)
    : super(
        EventOrdersState(
          allOrders: List.empty(),
          orders: List.empty(),
          orderFetchStatus: .initial,
          orderModificationStatus: .initial,
        ),
      );

  Future<void> initOrders(int eventID) async {
    emit(state.copyWith(orderFetchStatus: .loading));

    final dataState = await _repository.fetchAllOrders(eventID);

    if (dataState.isSuccess) {
      final orders = List<OrderModel>.from(dataState.response!);

      emit(
        state.copyWith(
          allOrders: orders,
          orders: orders,
          orderFetchStatus: .success,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(orderFetchStatus: .failure));
    }
  }

  void _changeModificationToInit() {
    emit(state.copyWith(orderModificationStatus: .initial));
  }

  Future<void> addOrder(EventOrderParams params) async {
    emit(state.copyWith(orderModificationStatus: .loading));

    final dataState = await _repository.insertOrder(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final allOrders = List<OrderModel>.from(state.allOrders)..add(addedOrder);

      emit(
        state.copyWith(allOrders: allOrders, orderModificationStatus: .success),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(orderModificationStatus: .failure));
    }
  }

  Future<void> editOrder(EventOrderParams params) async {
    emit(state.copyWith(orderModificationStatus: .loading));

    final dataState = await _repository.updateOrder(params);

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final allOrders = List<OrderModel>.from(state.allOrders)
        ..removeWhere((e) => e.id == params.id)
        ..add(addedOrder);

      emit(
        state.copyWith(
          allOrders: allOrders,
          orders: allOrders,
          orderModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(orderModificationStatus: .failure));
    }
  }

  Future<void> changeDeliveryStatus(int id, bool isDelivered) async {
    emit(state.copyWith(orderModificationStatus: .loading));

    final dataState = await _repository.changeOrderDeliveryStatus(
      id,
      isDelivered,
    );

    if (dataState.isSuccess) {
      final addedOrder = dataState.response!;
      final index = state.allOrders.indexWhere((e) => e.id == id);
      final allOrders = List<OrderModel>.from(state.allOrders)
        ..removeWhere((e) => e.id == id)
        ..insert(index, addedOrder);

      emit(
        state.copyWith(
          allOrders: allOrders,
          orders: allOrders,
          orderModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(orderModificationStatus: .failure));
    }
  }

  Future<void> removeOrder(int id) async {
    emit(state.copyWith(orderModificationStatus: .loading));

    final dataState = await _repository.deleteOrder(id);

    if (dataState.isSuccess) {
      final allOrders = List<OrderModel>.from(state.allOrders)
        ..removeWhere((e) => e.id == id);

      emit(
        state.copyWith(
          allOrders: allOrders,
          orders: allOrders,
          orderModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(orderModificationStatus: .failure));
    }
  }
}
