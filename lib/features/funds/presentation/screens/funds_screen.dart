import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/funds/presentation/cubit/funds/funds_cubit.dart';
import 'package:pay_pilot_plus/features/funds/presentation/widgets/add_fund_modal_view.dart';
import 'package:pay_pilot_plus/features/funds/presentation/widgets/edit_fund_modal_view.dart';

class FundsScreen extends StatefulWidget {
  static const routeName = '/funds';

  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<FundsCubit>().loadFunds();
    _debuncer = DebounceHelper();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debuncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صندوق ها')),
      body: BlocBuilder<FundsCubit, FundsState>(
        buildWhen: (p, c) => p.fundStatus != c.fundStatus,
        builder: (context, state) {
          final funds = state.funds;
          final isLoading =
              state.fundStatus == .loading || state.fundStatus == .initial;

          if (isLoading) {
            return AppLoadingState();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppTextField(
                  hint: 'جستجو',
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  onChange: (value) => _debuncer.call(
                    () => context.read<FundsCubit>().searchFund(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: funds.length,
                  emptyInboxMessage: 'هنوز هیچ صندوقی اضافه نشده است!',
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.fundBalanceScreen,
                          extra: {
                            AppArguments.serializedFundInfo: funds[index]
                                .toJson(),
                          },
                        );
                      },
                      onEdit: () {
                        AppBottomModalSheet.minHeightWithAppBar(
                          header: S.current.team_editTeam,
                          child: EditFundModalView(
                            fund: funds[index],
                            onPressedSubmit: (t) {
                              searchController.clear();
                              context.read<FundsCubit>().updateFund(t);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<FundsCubit>().deleteFund(funds[index].id);
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            funds[index].title,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          // Gap(3),
                          // Text.rich(
                          //   TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: S.current.contentTitle_joinAt,
                          //         style: Theme.of(context).textTheme.headlineSmall,
                          //       ),
                          //       if (members[index].joinAt != null)
                          //         TextSpan(
                          //           text: members[index]
                          //               .joinAt!
                          //               .formattedToJalali_yearMonth,
                          //           style: Theme.of(context).textTheme.displayMedium,
                          //         )
                          //       else
                          //         TextSpan(
                          //           text: '-',
                          //           style: Theme.of(context).textTheme.headlineSmall,
                          //         ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppBottomModalSheet.minHeightWithAppBar(
            header: S.current.team_addTeam,
            child: AddFundModalView(
              onPressedSubmit: (newFund) {
                searchController.clear();
                context.read<FundsCubit>().addFund(newFund);
              },
            ),
          );
        },
        backgroundColor: kSecondaryColor,
        splashColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
