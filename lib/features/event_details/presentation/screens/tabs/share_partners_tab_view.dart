import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_ratios_cubit/event_ratios_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/edit_event_fund_modal_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/edit_share_partner_modal_view.dart';

class SharePartnersTabView extends StatefulWidget {
  final EventModel eventDetails;
  const SharePartnersTabView(this.eventDetails, {super.key});

  @override
  State<SharePartnersTabView> createState() => _SharePartnersTabViewState();
}

class _SharePartnersTabViewState extends State<SharePartnersTabView> {
  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().changeTabStatus(.ratios);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventRatiosCubit, EventRatiosState>(
      buildWhen: (p, c) {
        final isFetched = p.ratioFetchStatus != c.ratioFetchStatus;
        final isModified =
            p.ratioModificationStatus != c.ratioModificationStatus;

        if (isFetched || isModified) return true;

        return false;
      },
      builder: (context, state) {
        final memberRatios = state.memberRatios;
        final fundRatios = state.fundRatios;

        final isLoadingToFetch =
            state.ratioFetchStatus.isInitial ||
            state.ratioFetchStatus.isLoading;
        final isLoadingToModified = state.ratioModificationStatus.isLoading;

        if (isLoadingToFetch || isLoadingToModified) {
          return AppLoadingState();
        }

        return ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: .circular(25),
                color: context.colorScheme.onSurface.withAlpha(30),
                border: Border.all(
                  color: context.colorScheme.onSurface.withAlpha(30),
                ),
              ),
              child: AppList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                itemCount: fundRatios.length,
                emptyInboxMessage: S.current.sharePartner_noFundRatio,
                itemBuilder: (context, index) {
                  return AppTileInRow(
                    onEdit: widget.eventDetails.isClosed
                        ? null
                        : () {
                            final eventState = context
                                .read<EventDetailsCubit>()
                                .state;

                            AppBottomModalSheet.minHeightWithAppBar(
                              header: S.current.sharePartner_editFund,
                              child: EditEventFundModalView(
                                eventDetails: widget.eventDetails,
                                funds: eventState.allFunds,
                                teamFundInfo: fundRatios[index],
                                fundRatios: state.fundRatios,
                                memberRatios: memberRatios,
                                onSubmit: (ratio) {
                                  context
                                      .read<EventRatiosCubit>()
                                      .editFundRatio(ratio);
                                },
                              ),
                            );
                          },
                    onDelete: widget.eventDetails.isClosed
                        ? null
                        : () {
                            context.read<EventRatiosCubit>().removeFundRatio(
                              fundRatios[index].id,
                            );
                          },
                    parent: Row(
                      children: [
                        Text(
                          '%${fundRatios[index].sharePercentage.toInt()}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Gap(12),
                        Expanded(
                          child: Text(
                            fundRatios[index].fundInfo.name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Gap(12),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: .circular(25),
                color: context.colorScheme.onSurface.withAlpha(30),
                border: Border.all(
                  color: context.colorScheme.onSurface.withAlpha(30),
                ),
              ),
              child: AppList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                itemCount: memberRatios.length,
                emptyInboxMessage: S.current.sharePartner_noMemberRatio,
                itemBuilder: (context, index) {
                  return AppTileInRow(
                    onEdit: widget.eventDetails.isClosed
                        ? null
                        : () {
                            final eventState = context
                                .read<EventDetailsCubit>()
                                .state;

                            AppBottomModalSheet.minHeightWithAppBar(
                              header: S.current.teamDetails_addMembers,
                              child: EditSharePartnerModalView(
                                eventDetails: widget.eventDetails,
                                users: eventState.allUsers,
                                sharePartnerInfo: memberRatios[index],
                                fundRatios: state.fundRatios,
                                memberRatios: memberRatios,
                                onSubmit: (ratio) {
                                  context
                                      .read<EventRatiosCubit>()
                                      .editMemberRatio(ratio);
                                },
                              ),
                            );
                          },
                    onDelete: widget.eventDetails.isClosed
                        ? null
                        : () {
                            context.read<EventRatiosCubit>().removeMemberRatio(
                              memberRatios[index].id,
                            );
                          },
                    parent: Row(
                      children: [
                        Text(
                          '%${memberRatios[index].sharePercentage.toInt()}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Gap(12),
                        Expanded(
                          child: Text(
                            memberRatios[index].userInfo.name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
