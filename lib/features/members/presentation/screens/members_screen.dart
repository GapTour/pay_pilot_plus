import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/members/presentation/cubit/members/members_cubit.dart';
import 'package:pay_pilot_plus/features/members/presentation/widgets/add_member_modal_view.dart';
import 'package:pay_pilot_plus/features/members/presentation/widgets/edit_member_modal_view.dart';

class MembersScreen extends StatefulWidget {
  static const routeName = '/members';

  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<MembersCubit>().loadMembers();
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
      body: BlocBuilder<MembersCubit, MembersState>(
        buildWhen: (p, c) => p.membersStatus != c.membersStatus,
        builder: (context, state) {
          final members = state.members;
          final isLoading =
              state.membersStatus == MembersStatus.loading ||
              state.membersStatus == MembersStatus.initial;

          if (isLoading) {
            return AppLoadingState();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppTextField(
                  hint: S.current.textField_hint_search,
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  onChange: (value) => _debuncer.call(
                    () => context.read<MembersCubit>().searchMember(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: members.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.memberBalanceScreen,
                          extra: {
                            AppArguments.serializedUserInfo: members[index]
                                .toJson(),
                          },
                        );
                      },
                      onEdit: () {
                        AppBottomModalSheet.maxHeightWithAppBar(
                          header: S.current.member_addMember,
                          child: EditMemberModalView(
                            member: members[index],
                            onPressedSubmit: (user) {
                              searchController.clear();
                              context.read<MembersCubit>().updateMember(user);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<MembersCubit>().deleteMember(
                          members[index].id,
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            members[index].name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          // Gap(3),
                          // Text.rich(
                          //   TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: S.current.contentTitle_joinAt,
                          //         style: Theme.of(context).textTheme.labelLarge,
                          //       ),
                          //       if (members[index].joinAt != null)
                          //         TextSpan(
                          //           text: members[index]
                          //               .joinAt!
                          //               .formattedToJalali_yearMonth,
                          //           style: Theme.of(context).textTheme.bodyMedium,
                          //         )
                          //       else
                          //         TextSpan(
                          //           text: '-',
                          //           style: Theme.of(context).textTheme.labelLarge,
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
            header: S.current.member_addMember,
            child: AddMemberModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<MembersCubit>().addMember(user);
              },
            ),
          );
        },
        backgroundColor: context.colorScheme.primary,
        splashColor: context.colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
