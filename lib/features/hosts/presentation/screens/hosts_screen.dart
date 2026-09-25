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
import 'package:pay_pilot_plus/features/hosts/presentation/cubit/hosts/hosts_cubit.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/widgets/add_host_modal_view.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/widgets/edit_host_modal_view.dart';

class HostsScreen extends StatefulWidget {
  static const routeName = '/hosts';

  const HostsScreen({super.key});

  @override
  State<HostsScreen> createState() => _HostsScreenState();
}

class _HostsScreenState extends State<HostsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<HostsCubit>().loadMembers();
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
      appBar: AppBar(title: Text('میزبانان')),
      body: BlocBuilder<HostsCubit, HostsState>(
        buildWhen: (p, c) => p.hostsStatus != c.hostsStatus,
        builder: (context, state) {
          final hosts = state.hosts;
          final isLoading =
              state.hostsStatus == .loading || state.hostsStatus == .initial;

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
                    () => context.read<HostsCubit>().searchMember(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: hosts.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.hostBalanceScreen,
                          extra: {
                            AppArguments.serializedUserInfo: hosts[index]
                                .toJson(),
                          },
                        );
                      },
                      onEdit: () {
                        AppBottomModalSheet.maxHeightWithAppBar(
                          header: 'ویرایش اطلاعات میزبان',
                          child: EditHostModalView(
                            host: hosts[index],
                            onPressedSubmit: (user) {
                              searchController.clear();
                              context.read<HostsCubit>().updateMember(user);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<HostsCubit>().deleteMember(
                          hosts[index].id,
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hosts[index].name,
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
          AppBottomModalSheet.maxHeightWithAppBar(
            header: 'اضافه کردن میزبان جدید',
            child: AddHostModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<HostsCubit>().addMember(user);
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
