import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailsBanner extends StatefulWidget {
  final String serializedEventInfo;
  const EventDetailsBanner({required this.serializedEventInfo, super.key});

  @override
  State<EventDetailsBanner> createState() => _EventDetailsBannerState();
}

class _EventDetailsBannerState extends State<EventDetailsBanner> {
  late EventModel eventInfo;
  final pageController = PageController();
  BigInt totalIncome = BigInt.zero;
  BigInt totalDiscount = BigInt.zero;
  BigInt totalNet = BigInt.zero;
  int totalGuests = 0;
  final mapExpenses = <SubsidiaryAccountType, BigInt>{};

  @override
  void initState() {
    super.initState();

    eventInfo = EventModel.fromJson(widget.serializedEventInfo);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EventRegistrationsCubit, EventRegistrationsState>(
          listenWhen: (p, c) {
            final isFetched =
                p.registrationFetchStatus != c.registrationFetchStatus;
            final isModified =
                p.registrationModificationStatus !=
                c.registrationModificationStatus;

            if (isFetched || isModified) return true;

            return false;
          },
          listener: (context, state) {
            totalGuests = state.allRegistrations.length;
            totalIncome = state.allRegistrations.fold(BigInt.zero, (
              sum,
              amount,
            ) {
              return sum + amount.grossAmount;
            });
            totalDiscount = state.allRegistrations.fold(BigInt.zero, (
              sum,
              amount,
            ) {
              return sum + amount.discountAmount;
            });
            totalNet = totalIncome - totalDiscount;

            setState(() {});
          },
        ),
        BlocListener<EventExpensesCubit, EventExpensesState>(
          listenWhen: (p, c) {
            final isFetched = p.expensesFetchStatus != c.expensesFetchStatus;
            final isModified =
                p.expenseModificationStatus != c.expenseModificationStatus;

            if (isFetched || isModified) return true;

            return false;
          },
          listener: (context, state) {
            mapExpenses.clear();
            for (final expense in state.allExpenses) {
              final type = expense.subsidiaryAccountType;
              final amount = expense.amount;

              if (mapExpenses.containsKey(type)) {
                mapExpenses[type] = mapExpenses[type]! + amount;
              } else {
                mapExpenses[type] = amount;
              }
            }

            final totalExpenses = mapExpenses.values.fold(BigInt.zero, (
              sum,
              amount,
            ) {
              return sum + amount;
            });
            totalNet = totalIncome - totalDiscount - totalExpenses;

            setState(() {});
          },
        ),
      ],
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: PageView(
              controller: pageController,
              allowImplicitScrolling: true,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    mainAxisSize: .max,

                    children: [
                      Text(
                        eventInfo.title,
                        style: context.themeOf.textTheme.bodyLarge?.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                      Gap(12),
                      AppWrapBuilder(
                        [
                          _WrapWhiteTile(
                            title: S.current.eventDetails_host,
                            value: eventInfo.hostInfo.name,
                          ),
                          _WrapWhiteTile(
                            title: S.current.textField_label_team,
                            value: eventInfo.teamInfo.name,
                          ),
                          _WrapWhiteTile(
                            title: S.current.eventDetails_heldOnDay,
                            value: eventInfo
                                .date
                                .formattedToJalali_yearMonthDayWeekDay,
                          ),
                          _WrapWhiteTile(
                            title: S.current.eventDetails_guestsCount,
                            value: BigInt.from(totalGuests).addSeparator(),
                          ),
                        ],
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      AppWrapBuilder(
                        [
                          _WrapWhiteTile(
                            title: S.current.eventDetails_grossIncome,
                            value: '${totalIncome.addSeparator()} +',
                          ),
                          _WrapOrangeTile(
                            title: S.current.eventDetails_discounts,
                            value: '${totalDiscount.addSeparator()}  -',
                          ),
                          ...mapExpenses.entries.map(
                            (e) => _WrapOrangeTile(
                              title: '${e.key.title}  ',
                              value: '${e.value.addSeparator()}  -',
                            ),
                          ),
                        ],
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),

                      Gap(8),
                      Spacer(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  S.current.common_balance,
                                  style: context.themeOf.textTheme.labelSmall!
                                      .copyWith(color: kOnPrimaryColor),
                                ),
                              ),
                              Text(
                                totalNet.addSeparator(),
                                style: context.themeOf.textTheme.labelSmall!
                                    .copyWith(color: kOnPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 2,
            effect: JumpingDotEffect(
              activeDotColor: kPrimaryColor,
              dotColor: kPrimaryColor.withAlpha(50),
            ),
            onDotClicked: (index) {
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WrapWhiteTile extends StatelessWidget {
  final String title;
  final String value;
  const _WrapWhiteTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title  ',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(color: kOnSecondaryColor.withAlpha(100)),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.displayMedium
                ?.copyWith(color: kOnSecondaryColor),
          ),
        ],
      ),
    );
  }
}

class _WrapOrangeTile extends StatelessWidget {
  final String title;
  final String value;
  const _WrapOrangeTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title  ',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(color: kOnSecondaryColor.withAlpha(100)),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.displayMedium
                ?.copyWith(color: kSecondaryColor),
          ),
        ],
      ),
    );
  }
}
