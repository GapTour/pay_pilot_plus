import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/attend_guest_modal_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/attend_member_modal_view.dart';

class RegistrationsTabView extends StatefulWidget {
  final EventModel eventDetails;
  const RegistrationsTabView(this.eventDetails, {super.key});

  @override
  State<RegistrationsTabView> createState() => _RegistrationsTabViewState();
}

class _RegistrationsTabViewState extends State<RegistrationsTabView> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().changeTabStatus(.guests);
    _debuncer = DebounceHelper();
  }

  /// طرف دیگر سند تسویه ثبت‌نام برای نمایش روی کاشی
  String? _counterparty(EventRegistrationModel item) {
    if (item.bankInfo != null) {
      return S.current.registration_depositedTo(item.bankInfo!.name);
    }
    if (item.assignmentInfo != null) {
      return S.current.registration_receivedBy(item.assignmentInfo!.name);
    }
    if (item.snacksAssignmentInfo != null) {
      return S.current.registration_snacksChargedTo(
        item.snacksAssignmentInfo!.name,
      );
    }
    if (!item.user.role.isGuest) {
      return S.current.registration_chargedToOwnAccount;
    }
    return null;
  }

  void _openEdit(EventRegistrationModel item) {
    final registrationsCubit = context.read<EventRegistrationsCubit>();
    final details = context.read<EventDetailsCubit>().state;

    AppBottomModalSheet.maxHeightWithAppBar(
      header: S.current.registration_editTitle,
      child: item.user.role.isGuest
          ? AttendGuestModalView(
              eventModel: widget.eventDetails,
              addedUsersID: registrationsCubit.state.addedUsersID,
              users: details.allUsers,
              banks: details.allBanks,
              funds: details.allFunds,
              initial: item,
              onSubmit: registrationsCubit.updateRegistration,
            )
          : AttendMemberModalView(
              eventModel: widget.eventDetails,
              addedUsersID: registrationsCubit.state.addedUsersID,
              users: details.allUsers,
              initial: item,
              onSubmit: registrationsCubit.updateRegistration,
            ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _debuncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventRegistrationsCubit, EventRegistrationsState>(
      listenWhen: (p, c) =>
          p.registrationModificationStatus != c.registrationModificationStatus,
      listener: (context, state) {
        if (state.registrationModificationStatus.isSuccess &&
            searchController.text.isNotEmpty) {
          searchController.clear();
          context.read<EventRegistrationsCubit>().searchItem('');
        }
      },
      buildWhen: (p, c) {
        final isFetched =
            p.registrationFetchStatus != c.registrationFetchStatus;
        final isModified =
            p.registrationModificationStatus !=
            c.registrationModificationStatus;

        if (isFetched || isModified) return true;

        return false;
      },
      builder: (context, state) {
        final registrations = state.registrations;

        final isLoadingToFetch =
            state.registrationFetchStatus.isInitial ||
            state.registrationFetchStatus.isLoading;
        final isLoadingToModified =
            state.registrationModificationStatus.isLoading;

        if (isLoadingToFetch || isLoadingToModified) {
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
                  () =>
                      context.read<EventRegistrationsCubit>().searchItem(value),
                ),
              ),
            ),
            Expanded(
              child: AppList(
                itemCount: registrations.length,
                emptyInboxMessage: S.current.registration_emptyStateContent,
                itemBuilder: (context, index) {
                  final item = registrations[index];

                  final counterparty = _counterparty(item);

                  return AppTile(
                    onEdit: widget.eventDetails.isClosed
                        ? null
                        : () => _openEdit(item),
                    onDelete: widget.eventDetails.isClosed
                        ? null
                        : () {
                            final eventDetailsState = context
                                .read<EventDetailsCubit>()
                                .state;
                            final eventDetails =
                                (eventDetailsState.fetchDetailStatus
                                        as FetchDetailSuccess)
                                    .eventDetails;

                            context
                                .read<EventRegistrationsCubit>()
                                .deleteRegistration(
                                  DeleteRegistrationParams(
                                    eventID: eventDetails.id,
                                    eventRegistrationID: item.id,
                                    status: item.status,
                                    userID: item.user.id,
                                  ),
                                );
                          },
                    shadowColor: item.user.role.isGuest
                        ? item.status.isPending
                              ? context.colorScheme.error
                              : null
                        : context.colorScheme.primary,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(8),
                                child: Center(
                                  child: Text(
                                    item.counter.toString(),
                                    style: TextStyle(
                                      color: context.colorScheme.onPrimary,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Gap(8),
                            Text(
                              item.user.name,
                              style: context.themeOf.textTheme.bodyMedium,
                            ),
                            Spacer(),
                            _AbsentCheckbox(item.id),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: S.current.expense_onDate,
                                      style:
                                          context.themeOf.textTheme.labelLarge,
                                    ),
                                    TextSpan(
                                      text:
                                          '   ${item.registeredAt.formattedToJalali_yearMonthDayWeekDay}',
                                      style:
                                          context.themeOf.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(item.netAmount.addSeparator()),
                          ],
                        ),
                        if (counterparty != null) ...[
                          Gap(4),
                          Text(
                            counterparty,
                            style: context.themeOf.textTheme.labelLarge,
                          ),
                        ],
                        if (item.discountAmount > BigInt.zero) ...[
                          Gap(4),
                          Text(
                            S.current.registration_grossMinusDiscount(
                              item.grossAmount.addSeparator(),
                              item.discountAmount.addSeparator(),
                            ),
                            style: context.themeOf.textTheme.labelMedium,
                          ),
                        ],
                        if (item.description != null &&
                            (item.description ?? '').isNotEmpty) ...[
                          Gap(7),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 8,
                              ),
                              child: Text(
                                item.description!,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: context.colorScheme.onPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ],
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

class _AbsentCheckbox extends StatelessWidget {
  final int itemID;
  const _AbsentCheckbox(this.itemID);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EventRegistrationsCubit, EventRegistrationsState, bool>(
      selector: (state) {
        final register = state.registrations.firstWhere((e) => e.id == itemID);

        return !register.wasAbsent;
      },
      builder: (context, isPresent) {
        return Checkbox.adaptive(
          value: isPresent,
          onChanged: (value) {
            if (value == null) return;
            context.read<EventRegistrationsCubit>().changeAbsentStatus(
              itemID,
              !value,
            );
          },
        );
      },
    );
  }
}
