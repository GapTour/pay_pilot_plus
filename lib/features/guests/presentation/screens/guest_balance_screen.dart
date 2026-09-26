import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_balance_description.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_hidden_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
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

    context.onPostFrame(() {
      context.read<GuestBalanceCubit>().loadBalanceInfo(
        userInfo.detailedAccountInfo.id,
      );
    });
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppSliverTabbedAppBar(
                title: 'گردش حساب',
                flexibleSpaceBackgroundColor: kSecondaryColor,
                infoWidget: _UserBanner(userInfo: userInfo),
                tabs: null,
              ),
            ];
          },
          body: BlocBuilder<GuestBalanceCubit, GuestBalanceState>(
            buildWhen: (p, c) => p.balanceStatus != c.balanceStatus,
            builder: (context, state) {
              return AppList(
                itemCount: state.journals.length,
                emptyInboxMessage: 'هیچ تراکنشی برای این کاربر ثبت نشده!',
                itemBuilder: (context, index) {
                  final journal = state.journals[index];

                  return AppJournalHiddenTile(
                    journal: journal,
                    debitTitle: 'دریافت نشده',
                    creditTitle: 'دریافتی',
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UserBanner extends StatelessWidget {
  final UserModel userInfo;
  const new({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestBalanceCubit, GuestBalanceState>(
      buildWhen: (p, c) => p.remainingStatus != c.remainingStatus,
      builder: (context, state) {
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
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
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
                                  ?.copyWith(color: kSecondaryColor),
                            ),
                    ),
                  ),
                ],
              ),
              Gap(12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مبلغ افتتاحیه  ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: userInfo.openingBalance.addSeparator(),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              Gap(8),
              AppBalanceDescription(
                plusNote:
                    'نشان دهنده مقدار طلبی است که باید از شخص دریافت شود.',
                minesNote:
                    'نشان دهنده ی مقدار بدهی است که باید به شخص پرداخت شود.',
              ),

              Gap(8),
            ],
          ),
        );
      },
    );
  }
}
