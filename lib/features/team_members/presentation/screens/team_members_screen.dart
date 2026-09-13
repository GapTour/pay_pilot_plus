import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/team_members/presentation/cubit/ratios_cubit.dart';
import 'package:pay_pilot_plus/features/team_members/presentation/widgets/add_ratio_modal_view.dart';
import 'package:pay_pilot_plus/features/team_members/presentation/widgets/edit_ratio_modal_view.dart';

class TeamMembersScreen extends StatefulWidget {
  static const routeName = '/team-members';

  const TeamMembersScreen({super.key});

  @override
  State<TeamMembersScreen> createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<TeamMembersScreen> {
  late String serializedTeamInfo;
  TeamModel? teamInfo;
  final members = <UserModel>[];
  final addedMembers = <int, double>{};

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      teamInfo = TeamModel.fromJson(serializedTeamInfo);
      context.read<RatiosCubit>().loadRatios(teamInfo?.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    serializedTeamInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedTeamInfo]!;

    return Scaffold(
      appBar: AppBar(title: Text(S.current.teamDetials_appBarTitle)),
      body: BlocBuilder<RatiosCubit, RatiosState>(
        builder: (context, state) {
          final teamMembers = state.ratios;
          members
            ..clear()
            ..addAll(state.members);
          addedMembers
            ..clear()
            ..addAll(state.addedMembers);

          final isLoading =
              state.teamMemberStatus == .initial ||
              state.teamMemberStatus == .loading;

          if (isLoading ||
              (teamInfo == null && state.teamMemberStatus != .failure)) {
            return AppLoadingState();
          }

          if (state.teamMemberStatus == .failure) {
            return Center(child: Text(S.current.warning_somethingWentWrong));
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            children: [
              Text(
                teamInfo!.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gap(12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: S.current.contentTitle_description,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: teamInfo!.description.parseDashIfIsEmpty,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Gap(8),
              Divider(),
              Gap(12),

              AppList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: teamMembers.length,
                emptyInboxMessage: S.current.teamDetails_emptyStateContent,
                itemBuilder: (context, index) {
                  return AppTileInRow(
                    onEdit: () {
                      AppBottomModalSheet.minHeightWithAppBar(
                        header: S.current.teamDetails_addMembers,
                        child: EditRatioModalView(
                          teamMember: teamMembers[index],
                          team: teamInfo!,
                          members: members,
                          addedMembers: addedMembers,
                          onPressedSubmit: (ratio) {
                            context.read<RatiosCubit>().updateRatio(ratio);
                          },
                        ),
                      );
                    },
                    onDelete: () {
                      context.read<RatiosCubit>().deleteRatio(
                        teamMembers[index].id,
                      );
                    },
                    parent: Row(
                      children: [
                        Text(
                          '%${teamMembers[index].sharePercentage.toInt()}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Gap(12),
                        Expanded(
                          child: Text(
                            teamMembers[index].userInfo.name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Gap(150),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<RatiosCubit, RatiosState>(
        builder: (context, state) {
          final isLoading =
              state.teamMemberStatus == .initial ||
              state.teamMemberStatus == .loading;

          final isFailure = state.teamMemberStatus == .failure;

          return FloatingActionButton(
            onPressed: isFailure || isLoading
                ? null
                : () {
                    AppBottomModalSheet.minHeightWithAppBar(
                      header: S.current.teamDetails_addMembers,
                      child: AddRatioModalView(
                        team: teamInfo!,
                        members: members,
                        addedMembers: addedMembers,
                        onPressedSubmit: (ratio) {
                          context.read<RatiosCubit>().addRatio(ratio);
                        },
                      ),
                    );
                  },
            backgroundColor: kSecondaryColor,
            splashColor: kPrimaryColor,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
