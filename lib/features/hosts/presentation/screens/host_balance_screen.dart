import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_balance_description.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_compact_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/cubit/host_balance/host_balance_cubit.dart';

class HostBalanceScreen extends StatefulWidget {
  static const routeName = '/host-balance';
  const new({super.key});

  @override
  State<HostBalanceScreen> createState() => _HostBalanceScreenState();
}

class _HostBalanceScreenState extends State<HostBalanceScreen> {
  late String serializedUserInfo;
  late UserModel userInfo;

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      context.read<HostBalanceCubit>().loadBalanceInfo(
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

    return BlocListener<HostBalanceCubit, HostBalanceState>(
      listenWhen: (p, c) => p.balanceStatus != c.balanceStatus,
      listener: (context, state) {
        if (state.balanceStatus.isSuccess) {
          context.read<HostBalanceCubit>().loadRemaining(state.journals);
        }
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppSliverTabbedAppBar(
                title: S.current.balance_appBarTitle,
                flexibleSpaceBackgroundColor: context.colorScheme.primary,
                infoWidget: _UserBanner(userInfo: userInfo),
                tabs: null,
              ),
            ];
          },
          body: BlocBuilder<HostBalanceCubit, HostBalanceState>(
            buildWhen: (p, c) => p.balanceStatus != c.balanceStatus,
            builder: (context, state) {
              return AppList(
                itemCount: state.journals.length,
                emptyInboxMessage: S.current.balance_emptyUserTransactions,
                itemBuilder: (context, index) {
                  final journal = state.journals[index];

                  return AppJournalCompactTile.fromJournal(journal);
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
    return BlocBuilder<HostBalanceCubit, HostBalanceState>(
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
                        color: context.colorScheme.onPrimary,
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
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${S.current.balance_openingAmount}  ',
                      style: Theme.of(context).textTheme.labelLarge
                          ?.copyWith(color: context.colorScheme.onPrimary),
                    ),
                    TextSpan(
                      text: userInfo.openingBalance.addSeparator(),
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: context.colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              Gap(8),
              AppBalanceDescription(
                plusNote: S.current.memberBalance_creditDescription,
                minesNote: S.current.memberBalance_debitDescription,
              ),

              Gap(8),
            ],
          ),
        );
      },
    );
  }
}
