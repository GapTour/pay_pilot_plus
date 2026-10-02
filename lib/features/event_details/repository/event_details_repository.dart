import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_expense_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_order_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_expense_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_order_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_details_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_expenses_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_fund_ratios_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_member_ratios_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_orders_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_registrations_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_details_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_expenses_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_fund_ratios_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_member_ratios_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_orders_source.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_registrations_source.dart';

abstract class IEventDetailsRepository
    implements
        IEventDetailsSource<
          DataState<List<BankModel>>,
          DataState<List<UserModel>>,
          DataState<List<FundModel>>,
          DataState<List<MenuItemModel>>
        >,
        IEventRegistrationsSource<
          DataState<List<EventRegistrationModel>>,
          DataState<int>
        >,
        IEventMemberRatiosSource<
          DataState<List<TeamMemberModel>>,
          DataState<TeamMemberModel>,
          DataState<int>
        >,
        IEventFundRatiosSource<
          DataState<List<TeamFundModel>>,
          DataState<TeamFundModel>,
          DataState<int>
        >,
        IEventOrdersSource<
          DataState<List<OrderModel>>,
          DataState<OrderModel>,
          DataState<int>
        >,
        IEventExpensesSource<
          DataState<List<EventExpenseModel>>,
          DataState<int>,
          DataState<EventExpenseModel>
        > {}

class EventDetailsRepository extends BaseRepository
    implements IEventDetailsRepository {
  final IEventDetailsLocalProvider _detailsLocalProvider;
  final IEventRegistrationsLocalProvider _registrationsLocalProvider;
  final IEventMemberRatiosLocalProvider _memberRatiosLocalProvider;
  final IEventFundRatiosLocalProvider _fundRatiosLocalProvider;
  final IEventOrdersLocalProvider _ordersLocalProvider;
  final IEventExpensesLocalProvider _expensesLocalProvider;

  EventDetailsRepository(
    this._detailsLocalProvider,
    this._registrationsLocalProvider,
    this._memberRatiosLocalProvider,
    this._fundRatiosLocalProvider,
    this._ordersLocalProvider,
    this._expensesLocalProvider,
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
  Future<DataState<int>> deleteMemberRatio(int id) {
    return safeDbCall(() => _memberRatiosLocalProvider.deleteMemberRatio(id));
  }

  @override
  Future<DataState<List<TeamMemberModel>>> fetchAllMemberRatios(int eventID) {
    return safeDbCall(
      () => _memberRatiosLocalProvider.fetchAllMemberRatios(eventID),
    );
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
  Future<DataState<TeamMemberModel>> insertMemberRatio(
    MemberAllocationParams params,
  ) {
    return safeDbCall(
      () => _memberRatiosLocalProvider.insertMemberRatio(params),
    );
  }

  @override
  Future<DataState<TeamMemberModel>> updateMemberRatio(
    MemberAllocationParams params,
  ) {
    return safeDbCall(
      () => _memberRatiosLocalProvider.updateMemberRatio(params),
    );
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

  @override
  Future<DataState<int>> deleteFundRatio(int id) {
    return safeDbCall(() => _fundRatiosLocalProvider.deleteFundRatio(id));
  }

  @override
  Future<DataState<List<TeamFundModel>>> fetchAllFundRatios(int eventID) {
    return safeDbCall(
      () => _fundRatiosLocalProvider.fetchAllFundRatios(eventID),
    );
  }

  @override
  Future<DataState<TeamFundModel>> insertFundRatio(
    FundAllocationParams params,
  ) {
    return safeDbCall(() => _fundRatiosLocalProvider.insertFundRatio(params));
  }

  @override
  Future<DataState<TeamFundModel>> updateFundRatio(
    FundAllocationParams params,
  ) {
    return safeDbCall(() => _fundRatiosLocalProvider.updateFundRatio(params));
  }

  @override
  Future<DataState<List<FundModel>>> fetchAllFunds() {
    return safeDbCall(() => _detailsLocalProvider.fetchAllFunds());
  }

  @override
  Future<DataState<int>> deleteExpense(String series) {
    return safeDbCall(() => _expensesLocalProvider.deleteExpense(series));
  }

  @override
  Future<DataState<EventExpenseModel>> insertExpenseSettledByBank(
    EventExpenseParams params,
  ) {
    return safeDbCall(
      () => _expensesLocalProvider.insertExpenseSettledByBank(params),
    );
  }

  @override
  Future<DataState<EventExpenseModel>> insertExpenseSettledByStaff(
    EventExpenseParams params,
  ) {
    return safeDbCall(
      () => _expensesLocalProvider.insertExpenseSettledByStaff(params),
    );
  }

  @override
  Future<DataState<List<EventExpenseModel>>> fetchAllExpenses(int eventID) {
    return safeDbCall(() => _expensesLocalProvider.fetchAllExpenses(eventID));
  }
}
