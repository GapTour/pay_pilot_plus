import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubits/bank_balance/bank_balance_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BankBalanceBanner extends StatefulWidget {
  final BankModel bankInfo;
  const new({required this.bankInfo, super.key});

  @override
  State<BankBalanceBanner> createState() => _BankBalanceBannerState();
}

class _BankBalanceBannerState extends State<BankBalanceBanner> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView(
            controller: pageController,
            allowImplicitScrolling: true,
            children: [
              _BankInfo(bankInfo: widget.bankInfo),
              BlocBuilder<BankBalanceCubit, BankBalanceState>(
                buildWhen: (p, c) => p.fundStatus != c.fundStatus,
                builder: (context, state) {
                  if (state.fundStatus.isLoading) return AppLoadingState();

                  return AppList(
                    itemCount: state.funds.length,
                    emptyInboxMessage: 'هیچ صندوقی ثبت نشده!',
                    itemBuilder: (context, index) {
                      final fund = state.funds[index];

                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(fund.title)),
                              Text(fund.amount.addSeparator()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
    );
  }
}

class _BankInfo extends StatelessWidget {
  final BankModel bankInfo;
  const new({required this.bankInfo});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankBalanceCubit, BankBalanceState>(
      listenWhen: (p, c) => p.balanceStatus != c.balanceStatus,
      listener: (context, state) {
        if (state.balanceStatus.isSuccess) {
          context.read<BankBalanceCubit>().loadFunds();
        }
      },
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
                      bankInfo.name,
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
                      text: 'شماره حساب  ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: bankInfo.number ?? '***',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              Gap(5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مبلغ افتتاحیه  ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: bankInfo.openingBalance.addSeparator(),
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
