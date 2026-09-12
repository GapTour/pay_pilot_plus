import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_order_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_details_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_orders_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_ratios_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_registrations_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_details_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_orders_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_ratios_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_registrations_source.dart';

abstract class IEventDetailsRepository
    implements
        IEventDetailsSource<
          DataState<List<BankModel>>,
          DataState<List<UserModel>>,
          DataState<List<MenuItemModel>>
        >,
        IEventRegistrationsSource<
          DataState<List<EventRegistrationModel>>,
          DataState<int>
        >,
        IEventRatiosSource<
          DataState<List<TeamMemberModel>>,
          DataState<TeamMemberModel>,
          DataState<int>
        >,
        IEventOrdersSource<
          DataState<List<OrderModel>>,
          DataState<OrderModel>,
          DataState<int>
        > {}

class EventDetailsRepository extends BaseRepository
    implements IEventDetailsRepository {
  final IEventDetailsLocalProvider _detailsLocalProvider;
  final IEventRegistrationsLocalProvider _registrationsLocalProvider;
  final IEventRatiosLocalProvider _ratiosLocalProvider;
  final IEventOrdersLocalProvider _ordersLocalProvider;

  EventDetailsRepository(
    this._detailsLocalProvider,
    this._registrationsLocalProvider,
    this._ratiosLocalProvider,
    this._ordersLocalProvider,
  );

  @override
  Future<DataState<OrderModel>> changeOrderDeliveryStatus(
    int id,
    bool isDelivered,
  ) {
    return safeDbCall(
      () => _ordersLocalProvider.changeOrderDeliveryStatus(id, isDelivered),
    );
  }

  @override
  Future<DataState<int>> deleteOrder(int id) {
    return safeDbCall(() => _ordersLocalProvider.deleteOrder(id));
  }

  @override
  Future<DataState<int>> deleteRegistration(DeleteRegistrationParams params) {
    return safeDbCall(
      () => _registrationsLocalProvider.deleteRegistration(params),
    );
  }

  @override
  Future<DataState<List<OrderModel>>> fetchAllOrders(int eventID) {
    return safeDbCall(() => _ordersLocalProvider.fetchAllOrders(eventID));
  }

  @override
  Future<DataState<OrderModel>> insertOrder(EventOrderParams params) {
    return safeDbCall(() => _ordersLocalProvider.insertOrder(params));
  }

  @override
  Future<DataState<List<EventRegistrationModel>>> registerGuests(
    EventRegistrationParams params,
  ) {
    return safeDbCall(() => _registrationsLocalProvider.registerGuests(params));
  }

  @override
  Future<DataState<OrderModel>> updateOrder(EventOrderParams params) {
    return safeDbCall(() => _ordersLocalProvider.updateOrder(params));
  }

  @override
  Future<DataState<List<BankModel>>> fetchAllBanks() {
    return safeDbCall(() => _detailsLocalProvider.fetchAllBanks());
  }

  @override
  Future<DataState<List<MenuItemModel>>> fetchAllMenuItems() {
    return safeDbCall(() => _detailsLocalProvider.fetchAllMenuItems());
  }

  @override
  Future<DataState<List<UserModel>>> fetchAllUsers() {
    return safeDbCall(() => _detailsLocalProvider.fetchAllUsers());
  }

  @override
  Future<DataState<int>> deleteRatio(int id) {
    return safeDbCall(() => _ratiosLocalProvider.deleteRatio(id));
  }

  @override
  Future<DataState<List<TeamMemberModel>>> fetchAllRatios(int eventID) {
    return safeDbCall(() => _ratiosLocalProvider.fetchAllRatios(eventID));
  }

  @override
  Future<DataState<List<EventRegistrationModel>>> fetchAllRegistrations(
    int eventID,
  ) {
    return safeDbCall(
      () => _registrationsLocalProvider.fetchAllRegistrations(eventID),
    );
  }

  @override
  Future<DataState<TeamMemberModel>> insertRatio(
    EventPartnerShareParams params,
  ) {
    return safeDbCall(() => _ratiosLocalProvider.insertRatio(params));
  }

  @override
  Future<DataState<TeamMemberModel>> updateRatio(
    EventPartnerShareParams params,
  ) {
    return safeDbCall(() => _ratiosLocalProvider.updateRatio(params));
  }

  @override
  Future<DataState<int>> changeAbsentStatus(int registrationID, bool isAbsent) {
    return safeDbCall(
      () => _registrationsLocalProvider.changeAbsentStatus(
        registrationID,
        isAbsent,
      ),
    );
  }

  @override
  Future<DataState<List<EventRegistrationModel>>> registerMembers(
    EventRegistrationParams params,
  ) {
    return safeDbCall(
      () => _registrationsLocalProvider.registerMembers(params),
    );
  }
}
