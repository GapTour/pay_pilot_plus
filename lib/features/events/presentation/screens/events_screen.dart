import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/events/presentation/blocs/events_cubit/events_cubit.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/add_event_modal_view.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/close_event_modal_view.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/edit_event_modal_view.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/open_event_modal_view.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events';

  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<EventsCubit>().loadEvents();
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
      appBar: AppBar(title: Text(S.current.event_appBarTitle)),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          final events = state.events;
          final isLoading =
              state.eventsStatus is EventInitial ||
              state.eventsStatus is EventLoading;

          if (isLoading) return AppLoadingState();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppTextField(
                  hint: 'جستجو',
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  onChange: (value) => _debuncer.call(
                    () => context.read<EventsCubit>().searchEvent(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: events.length,
                  emptyInboxMessage: S.current.event_emptyStateContent,
                  itemBuilder: (context, index) {
                    final currentEvent = events[index];

                    return AppTileInRow(
                      onEdit: () {
                        AppBottomModalSheet.maxHeightWithAppBar(
                          header: S.current.event_editEvent,
                          child: EditEventModalView(
                            eventDetails: currentEvent,
                            teams: state.teams,
                            hosts: state.hosts,
                            onPressedSubmit: (event) {
                              searchController.clear();
                              context.read<EventsCubit>().editEvent(event);
                            },
                          ),
                        );
                      },
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.eventDetailsScreen,
                          extra: {
                            AppArguments.serializedEventInfo: currentEvent
                                .toJson(),
                          },
                        );
                      },
                      // onDelete: () {
                      //   context.read<EventsCubit>().deleteEvent(currentEvent.id);
                      // },
                      previewButtonTitle: S.current.button_title_preview,
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentEvent.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(color: kSecondaryColor),
                          ),
                          Gap(3),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${S.current.contentTitle_onDate}  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                                TextSpan(
                                  text: currentEvent
                                      .date
                                      .formattedToJalali_yearMonthDayWeekDay,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          if (!currentEvent.isClosed)
                            AppElevatedButton(
                              onTap: () {
                                AppBottomModalSheet.maxHeightWithAppBar(
                                  header: 'بستن حساب رویداد',
                                  child: CloseEventModalView(
                                    eventModel: currentEvent,
                                    onSubmit: (closedEvent) {
                                      context.read<EventsCubit>().closeEvent(
                                        closedEvent,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'بستن حساب',
                                  style:
                                      context.themeOf.textTheme.displayMedium,
                                ),
                              ),
                            ),
                          if (currentEvent.isClosed)
                            AppElevatedButton(
                              onTap: () {
                                AppBottomModalSheet.minHeightWithAppBar(
                                  header: 'دسترسی به حساب این رویداد',
                                  child: OpenEventModalView(
                                    eventModel: currentEvent,
                                    onSubmit: (_) {
                                      context.read<EventsCubit>().openEvent(
                                        currentEvent.id,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'بازگشایی حساب',
                                  style:
                                      context.themeOf.textTheme.displayMedium,
                                ),
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
      ),
      floatingActionButton: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          final isLoading =
              state.eventsStatus is EventInitial ||
              state.eventsStatus is EventLoading;
          final isFailure = state.eventsStatus is EventFailure;

          return FloatingActionButton(
            onPressed: isLoading || isFailure
                ? null
                : () {
                    AppBottomModalSheet.maxHeightWithAppBar(
                      header: S.current.event_addEvent,
                      child: AddEventModalView(
                        teams: state.teams,
                        hosts: state.hosts,
                        onPressedSubmit: (event) {
                          searchController.clear();
                          context.read<EventsCubit>().addEvent(event);
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
