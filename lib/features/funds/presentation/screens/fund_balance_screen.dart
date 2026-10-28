import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
import 'package:pay_pilot_plus/features/funds/presentation/cubit/fund_balance/fund_balance_cubit.dart';
import 'package:pay_pilot_plus/features/funds/presentation/widgets/fund_balance_tile.dart';

class FundBalanceScreen extends StatefulWidget {
  static const routeName = '/fund-balance';
  const new({super.key});

  @override
  State<FundBalanceScreen> createState() => _FundBalanceScreenState();
}

class _FundBalanceScreenState extends State<FundBalanceScreen> {
  late String serializedFundInfo;
  late FundModel fundInfo;

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      context.read<FundBalanceCubit>().loadFunds(fundInfo.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    serializedFundInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedFundInfo]!;

    fundInfo = FundModel.fromJson(serializedFundInfo);

    return BlocListener<FundBalanceCubit, FundBalanceState>(
      listenWhen: (p, c) => p.fundStatus != c.fundStatus,
      listener: (context, state) {
        if (state.fundStatus.isSuccess) {
          context.read<FundBalanceCubit>().loadRemaining(
            openingBalance: fundInfo.openingBalance,
            fundBalances: state.funds,
          );
        }
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppSliverTabbedAppBar(
                title: S.current.balance_appBarTitle,
                flexibleSpaceBackgroundColor: kSecondaryColor,
                expandedInfoHeight: 80,
                infoWidget: _FundBanner(fundInfo: fundInfo),
                tabs: null,
              ),
            ];
          },
          body: BlocBuilder<FundBalanceCubit, FundBalanceState>(
            buildWhen: (p, c) => p.remainingStatus != c.remainingStatus,
            builder: (context, state) {
              return AppList(
                itemCount: state.funds.length,
                emptyInboxMessage: S.current.fundBalance_emptyStateContent,
                itemBuilder: (context, index) {
                  final balanceInfo = state.funds[index];

                  return FundBalanceTile(
                    balanceInfo: balanceInfo,
                    debitTitle: S.current.fundBalance_added,
                    creditTitle: S.current.fundBalance_deducted,
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

class _FundBanner extends StatelessWidget {
  final FundModel fundInfo;
  const new({required this.fundInfo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundBalanceCubit, FundBalanceState>(
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
                      fundInfo.title,
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
                      text: '${S.current.balance_openingAmount}  ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: fundInfo.openingBalance.addSeparator(),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
