import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_balance_description.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_hidden_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_balance_source.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guest_balance/guest_balance_cubit.dart';

class GuestBalanceScreen extends StatefulWidget {
  static const routeName = '/guest-balance';
  const new({super.key});

  @override
  State<GuestBalanceScreen> createState() => _GuestBalanceScreenState();
}

class _GuestBalanceScreenState extends State<GuestBalanceScreen> {
  late String serializedUserInfo;
  late UserModel userInfo;

  @override
  void initState() {
    super.initState();

    context.onPostFrame(_load);
  }

  void _load() {
    context.read<GuestBalanceCubit>()
      ..loadBalanceInfo(userInfo.detailedAccountInfo.id)
      ..loadRegistrations(userInfo.id);
  }

  /// رویداد را باز می‌کند و پس از برگشت، اطلاعات را دوباره می‌خواند
  /// چون ممکن است ثبت‌نام در صفحه رویداد تغییر کرده باشد
  Future<void> _openEvent(GuestRegistration registration) async {
    await context.pushNamed(
      AppRoutes.eventDetailsScreen,
      extra: {AppArguments.serializedEventInfo: registration.event.toJson()},
    );
    if (mounted) _load();
  }

  @override
  Widget build(BuildContext context) {
    serializedUserInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedUserInfo]!;

    userInfo = UserModel.fromJson(serializedUserInfo);

    return BlocListener<GuestBalanceCubit, GuestBalanceState>(
      listenWhen: (p, c) => p.balanceStatus != c.balanceStatus,
      listener: (context, state) {
        if (state.balanceStatus.isSuccess) {
          context.read<GuestBalanceCubit>().loadRemaining(state.journals);
        }
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    AppSliverTabbedAppBar(
                      title: S.current.balance_appBarTitle,
                      flexibleSpaceBackgroundColor: context.colorScheme.primary,
                      infoWidget: _UserBanner(userInfo: userInfo),
                      tabs: [
                        Tab(text: S.current.guestBalance_tab_account),
                        Tab(text: S.current.guestBalance_tab_events),
                      ],
                    ),
                  ];
                },
            body: TabBarView(
              children: [
                const _JournalsTab(),
                _RegistrationsTab(onOpen: _openEvent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _JournalsTab extends StatelessWidget {
  const _JournalsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestBalanceCubit, GuestBalanceState>(
      buildWhen: (p, c) => p.balanceStatus != c.balanceStatus,
      builder: (context, state) {
        if (state.balanceStatus.isLoading) return AppLoadingState();

        return AppList(
          itemCount: state.journals.length,
          emptyInboxMessage: S.current.balance_emptyUserTransactions,
          itemBuilder: (context, index) {
            return AppJournalHiddenTile(
              journal: state.journals[index],
              debitTitle: S.current.guestBalance_notReceived,
              creditTitle: S.current.guestBalance_received,
            );
          },
        );
      },
    );
  }
}

/// همه رویدادهای مهمان با مبلغ کل، تخفیف و مبلغ نهایی هر ثبت‌نام
class _RegistrationsTab extends StatelessWidget {
  final ValueChanged<GuestRegistration> onOpen;
  const _RegistrationsTab({required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestBalanceCubit, GuestBalanceState>(
      buildWhen: (p, c) => p.registrationsStatus != c.registrationsStatus,
      builder: (context, state) {
        if (state.registrationsStatus.isLoading) return AppLoadingState();

        final items = state.registrations;

        return AppList(
          itemCount: items.length,
          emptyInboxMessage: S.current.guestBalance_emptyEvents,
          itemBuilder: (context, index) {
            final item = items[index];

            // لغوشده‌ها در تاریخچه می‌مانند ولی کم‌رنگ
            return Opacity(
              opacity: item.status.isCancelled ? 0.5 : 1,
              child: AppTileInRow(
                onPreview: () => onOpen(item),
                parent: _RegistrationInfo(item),
              ),
            );
          },
        );
      },
    );
  }
}

class _RegistrationInfo extends StatelessWidget {
  final GuestRegistration item;
  const _RegistrationInfo(this.item);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.themeOf.textTheme;
    final attendance = item.wasAbsent
        ? S.current.guestBalance_absent
        : S.current.guestBalance_present;

    Widget line(String label, BigInt amount) => Row(
      children: [
        Expanded(child: Text(label, style: textTheme.labelLarge)),
        Text(amount.addSeparator(), style: textTheme.bodyMedium),
      ],
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(item.event.title, style: textTheme.titleMedium),
        Text(
          '${item.event.date.formattedToJalali_yearMonthDay}  ·  $attendance',
          style: textTheme.bodySmall,
        ),
        Gap(6),
        line(S.current.textField_label_grossAmount, item.grossAmount),
        line(S.current.textField_label_discount, item.discountAmount),
        line(S.current.guestBalance_netAmount, item.netAmount),
      ],
    );
  }
}

class _UserBanner extends StatelessWidget {
  final UserModel userInfo;
  const new({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestBalanceCubit, GuestBalanceState>(
      buildWhen: (p, c) =>
          p.remainingStatus != c.remainingStatus ||
          p.registrationsStatus != c.registrationsStatus,
      builder: (context, state) {
        final onPrimary = context.colorScheme.onPrimary;
        final labelStyle = context.themeOf.textTheme.labelLarge?.copyWith(
          color: onPrimary,
        );
        final valueStyle = context.themeOf.textTheme.bodyMedium?.copyWith(
          color: onPrimary,
        );

        TextSpan pair(String label, String value) => TextSpan(
          children: [
            TextSpan(text: '$label  ', style: labelStyle),
            TextSpan(text: value, style: valueStyle),
          ],
        );

        // ارتفاع بنر فقط یک بار اندازه گرفته می‌شود؛ هر آمار دو خط ثابت دارد
        // و تا بارگذاری تمام نشده خط تیره نشان می‌دهد
        Widget stat(String label, String value) => Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(label, style: labelStyle, maxLines: 1),
              Text(value, style: valueStyle, maxLines: 1),
            ],
          ),
        );

        final hasSummary = state.registrationsStatus.isSuccess;
        String summary(String Function() value) => hasSummary ? value() : '-';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            mainAxisSize: .max,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      userInfo.name,
                      style: context.themeOf.textTheme.bodyLarge?.copyWith(
                        color: onPrimary,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3,
                      ),
                      child: state.remainingStatus.isLoading
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2.0,
                              ),
                              child: AppLoadingState(),
                            )
                          : Text(
                              state.remainingAmount.addSeparatorWithSymbol(),
                              style: context.themeOf.textTheme.bodyLarge
                                  ?.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                            ),
                    ),
                  ),
                ],
              ),
              Gap(12),
              Text.rich(
                pair(
                  S.current.balance_openingAmount,
                  userInfo.openingBalance.addSeparator(),
                ),
              ),
              Gap(6),
              Row(
                children: [
                  stat(
                    S.current.guestBalance_eventsCount,
                    summary(() => state.activeRegistrations.length.toString()),
                  ),
                  stat(
                    S.current.guestBalance_totalGross,
                    summary(() => state.totalGross.addSeparator()),
                  ),
                ],
              ),
              Gap(6),
              Row(
                children: [
                  stat(
                    S.current.guestBalance_totalDiscount,
                    summary(() => state.totalDiscount.addSeparator()),
                  ),
                  stat(
                    S.current.guestBalance_totalNet,
                    summary(() => state.totalNet.addSeparator()),
                  ),
                ],
              ),
              Gap(8),
              AppBalanceDescription(
                plusNote: S.current.guestBalance_creditDescription,
                minesNote: S.current.guestBalance_debitDescription,
              ),

              Gap(8),
            ],
          ),
        );
      },
    );
  }
}
