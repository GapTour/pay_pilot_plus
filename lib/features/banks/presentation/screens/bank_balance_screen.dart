import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_colors.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_circular_menu_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_compact_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_sliver_tabbed_app_bar.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubits/bank_balance/bank_balance_cubit.dart';
import 'package:pay_pilot_plus/features/banks/presentation/widgets/bank_balance_banner.dart';
import 'package:pay_pilot_plus/features/banks/presentation/widgets/pay_to_modal_view.dart';
import 'package:pay_pilot_plus/features/banks/presentation/widgets/receive_from_modal_view.dart';

class BankBalanceScreen extends StatefulWidget {
  static const routeName = '/bank-balance';
  const new({super.key});

  @override
  State<BankBalanceScreen> createState() => _BankBalanceScreenState();
}

class _BankBalanceScreenState extends State<BankBalanceScreen> {
  late String serializedBankInfo;
  late BankModel bankDetails;

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      context.read<BankBalanceCubit>().loadBalanceInfo(
        bankDetails.detailedAccountInfo.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    serializedBankInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedBankInfo]!;

    bankDetails = BankModel.fromJson(serializedBankInfo);

    return BlocListener<BankBalanceCubit, BankBalanceState>(
      listenWhen: (p, c) => p.balanceStatus != c.balanceStatus,
      listener: (context, state) {
        if (state.balanceStatus.isSuccess) {
          context.read<BankBalanceCubit>().loadRemaining(state.journals);
        }
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppSliverTabbedAppBar(
                title: S.current.balance_appBarTitle,
                flexibleSpaceBackgroundColor: context.colorScheme.primary,
                expandedInfoHeight: 150,
                infoWidget: BankBalanceBanner(bankInfo: bankDetails),
                tabs: null,
              ),
            ];
          },
          body: BlocBuilder<BankBalanceCubit, BankBalanceState>(
            buildWhen: (p, c) => p.balanceStatus != c.balanceStatus,
            builder: (context, state) {
              return AppList(
                itemCount: state.journals.length,
                emptyInboxMessage: S.current.bankBalance_emptyStateContent,
                itemBuilder: (context, index) {
                  final journal = state.journals[index];

                  return AppJournalCompactTile.fromJournal(journal);
                },
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<BankBalanceCubit, BankBalanceState>(
          buildWhen: (p, c) => p.balanceStatus != c.balanceStatus,
          builder: (context, state) {
            return AppCircularMenuButton(
              children: [
                RawMaterialButton(
                  onPressed: state.balanceStatus.isSuccess
                      ? () {
                          AppBottomModalSheet.maxHeightWithAppBar(
                            header: S.current.bankBalance_payFrom(
                              bankDetails.name,
                            ),
                            child: PayToModalView(
                              bankDetails: bankDetails,
                              funds: state.allFunds,
                              events: state.allEvents,
                              users: state.allUsers,
                              onSubmit: (params) {
                                context.read<BankBalanceCubit>().payTo(params);
                              },
                            ),
                          );
                        }
                      : null,
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(
                    Icons.payments_outlined,
                    color: context.colorScheme.error,
                  ),
                ),
                RawMaterialButton(
                  onPressed: state.balanceStatus.isSuccess
                      ? () {
                          AppBottomModalSheet.maxHeightWithAppBar(
                            header: S.current.bankBalance_payTo(
                              bankDetails.name,
                            ),
                            child: ReceiveFromModalView(
                              bankDetails: bankDetails,
                              funds: state.allFunds,
                              events: state.allEvents,
                              users: state.allUsers,
                              onSubmit: (params) {
                                context.read<BankBalanceCubit>().receiveFrom(
                                  params,
                                );
                              },
                            ),
                          );
                        }
                      : null,
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(
                    Icons.payments,
                    color: AppStatusColors.of(context).success,
                  ),
                ),

                SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }
}
