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
import 'package:pay_pilot_plus/features/teams/presentation/cubit/teams_cubit.dart';
import 'package:pay_pilot_plus/features/teams/presentation/widgets/add_team_modal_view.dart';
import 'package:pay_pilot_plus/features/teams/presentation/widgets/edit_team_modal_view.dart';

class TeamsScreen extends StatefulWidget {
  static const routeName = '/teams';

  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<TeamsCubit>().loadTeams();
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
      appBar: AppBar(title: Text(S.current.team_appBarTitle)),
      body: BlocBuilder<TeamsCubit, TeamsState>(
        buildWhen: (p, c) => p.teamsStatus != c.teamsStatus,
        builder: (context, state) {
          final teams = state.teams;
          final isLoading =
              state.teamsStatus == .loading || state.teamsStatus == .initial;

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
                    () => context.read<TeamsCubit>().searchMember(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: teams.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.teamMembersScreen,
                          extra: {
                            AppArguments.serializedTeamInfo: teams[index]
                                .toJson(),
                          },
                        );
                      },
                      onEdit: () {
                        AppBottomModalSheet.minHeightWithAppBar(
                          header: S.current.team_editTeam,
                          child: EditTeamModalView(
                            team: teams[index],
                            onPressedSubmit: (t) {
                              searchController.clear();
                              context.read<TeamsCubit>().updateMember(t);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<TeamsCubit>().deleteMember(
                          teams[index].id,
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teams[index].title,
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
          AppBottomModalSheet.minHeightWithAppBar(
            header: S.current.team_addTeam,
            child: AddTeamModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<TeamsCubit>().addMember(user);
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
