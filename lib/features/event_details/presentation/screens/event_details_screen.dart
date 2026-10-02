import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_circular_menu_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_ratios_cubit/event_ratios_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/screens/tabs/expenses_tab_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/screens/tabs/orders_tab_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/screens/tabs/registrations_tab_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/screens/tabs/share_partners_tab_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/add_expense_by_bank_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/add_expense_by_staff_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/add_fund_ratio_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/add_share_partner_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/attend_guest_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/attend_member_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/buttons/share_registrations_button.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/event_details_banner.dart';

class EventDetailsScreen extends StatefulWidget {
  static const routeName = '/event-details';
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late String serializedEventInfo;
  late EventModel eventDetails;
  final allUsers = <UserModel>[];
  final allFunds = <FundModel>[];
  final allBanks = <BankModel>[];
  final allMenuItems = <MenuItemModel>[];

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      context.read<EventDetailsCubit>().initEventDetails(serializedEventInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    serializedEventInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedEventInfo]!;

    eventDetails = EventModel.fromJson(serializedEventInfo);

    return MultiBlocListener(
      listeners: [
        BlocListener<EventDetailsCubit, EventDetailsState>(
          listenWhen: (p, c) => p.fetchDetailStatus != c.fetchDetailStatus,
          listener: (context, state) {
            if (state.fetchDetailStatus is FetchDetailSuccess) {
              eventDetails =
                  (state.fetchDetailStatus as FetchDetailSuccess).eventDetails;
              allBanks
                ..clear()
                ..addAll(state.allBanks);
              allUsers
                ..clear()
                ..addAll(state.allUsers);
              allMenuItems
                ..clear()
                ..addAll(state.allMenuItems);
              allFunds
                ..clear()
                ..addAll(state.allFunds);

              context.read<EventRegistrationsCubit>().initRegistrations(
                eventDetails.id,
              );
            }
          },
        ),
        BlocListener<EventRegistrationsCubit, EventRegistrationsState>(
          listenWhen: (p, c) =>
              p.registrationFetchStatus != c.registrationFetchStatus,
          listener: (context, state) {
            if (state.registrationFetchStatus.isSuccess) {
              context.read<EventRatiosCubit>().initRatios(eventDetails.id);
            }
          },
        ),
        BlocListener<EventRatiosCubit, EventRatiosState>(
          listenWhen: (p, c) => p.ratioFetchStatus != c.ratioFetchStatus,
          listener: (context, state) {
            if (state.ratioFetchStatus.isSuccess) {
              // context.read<EventOrdersCubit>().initOrders(eventDetails.id);
              context.read<EventExpensesCubit>().initExpenses(eventDetails.id);
            }
          },
        ),
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    AppSliverTabbedAppBar(
                      title: S.current.eventDetails_appBarTitle,
                      flexibleSpaceBackgroundColor: kSecondaryColor,
                      expandedInfoHeight: 150.0,
                      infoWidget: EventDetailsBanner(
                        serializedEventInfo: serializedEventInfo,
                      ),
                      tabs: <Widget>[
                        Tab(text: 'مهمانان'),
                        Tab(text: S.current.eventDetails_tabBar_orders),
                        Tab(text: 'هزینه ها'),
                        Tab(text: 'درصدها'),
                      ],
                    ),
                  ];
                },
            body: TabBarView(
              children: <Widget>[
                RegistrationsTabView(eventDetails),
                OrdersTabView(),
                ExpensesTabView(eventDetails),
                SharePartnersTabView(eventDetails),
              ],
            ),
          ),
        ),
        floatingActionButton: eventDetails.isClosed
            ? null
            : BlocBuilder<EventDetailsCubit, EventDetailsState>(
                buildWhen: (p, c) => p.detailsTabStatus != c.detailsTabStatus,
                builder: (context, state) {
                  return AppCircularMenuButton(
                    children: [
                      if (state.detailsTabStatus.isGuests) ...[
                        AttendGuestButton(
                          serializedEventInfo: serializedEventInfo,
                          allBanks: allBanks,
                          allUsers: allUsers,
                        ),
                        AttendMemberButton(
                          serializedEventInfo: serializedEventInfo,
                          allUsers: allUsers,
                        ),
                        ShareRegistrationsButton(
                          serializedEventInfo: serializedEventInfo,
                        ),
                      ],
                      if (state.detailsTabStatus.isExpenses) ...[
                        AddExpenseByBankButton(
                          allFunds: allFunds,
                          allBanks: allBanks,
                          serializedEventInfo: serializedEventInfo,
                        ),
                        AddExpenseByStaffButton(
                          allUsers: allUsers,
                          serializedEventInfo: serializedEventInfo,
                        ),
                      ],
                      if (state.detailsTabStatus.isRatios) ...[
                        AddSharePartnerButton(
                          serializedEventInfo: serializedEventInfo,
                          allUsers: allUsers,
                        ),
                        AddFundRatioButton(
                          serializedEventInfo: serializedEventInfo,
                          allFunds: allFunds,
                        ),
                      ],
                      SizedBox.shrink(),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
