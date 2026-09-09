import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubit/banks_cubit.dart';
import 'package:pay_pilot_plus/features/banks/presentation/widgets/add_bank_modal_view.dart';
import 'package:pay_pilot_plus/features/banks/presentation/widgets/edit_bank_modal_view.dart';

class BanksScreen extends StatefulWidget {
  static const routeName = '/banks';

  const BanksScreen({super.key});

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<BanksCubit>().loadBanks();
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
      appBar: AppBar(title: Text(S.current.member_appBarTitle)),
      body: BlocBuilder<BanksCubit, BanksState>(
        buildWhen: (p, c) => p.banksStatus != c.banksStatus,
        builder: (context, state) {
          final banks = state.banks;
          final isLoading =
              state.banksStatus == .loading || state.banksStatus == .initial;

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
                    () => context.read<BanksCubit>().searchBank(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: banks.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      // onPreview: () {
                      //   // context.pushNamed(
                      //   //   AppRoutes.memberDetailsScreen,
                      //   //   pathParameters: {
                      //   //     AppArguments.memberDetails: '${members[index].id}',
                      //   //   },
                      //   // );
                      // },
                      onEdit: () {
                        AppBottomModalSheet.minHeightWithAppBar(
                          header: S.current.member_addMember,
                          child: EditBankModalView(
                            bank: banks[index],
                            onPressedSubmit: (user) {
                              searchController.clear();
                              context.read<BanksCubit>().updateBank(user);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<BanksCubit>().deleteBank(banks[index].id);
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banks[index].name,
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
            header: S.current.member_addMember,
            child: AddBankModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<BanksCubit>().addBank(user);
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
