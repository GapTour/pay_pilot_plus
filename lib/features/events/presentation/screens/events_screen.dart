import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/events/presentation/cubit/events_cubit.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/add_event_modal_view.dart';
import 'package:pay_pilot_plus/features/events/presentation/widgets/edit_event_modal_view.dart';

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
                    return AppTileInRow(
                      onEdit: () {
                        AppBottomModalSheet.minHeightWithAppBar(
                          header: S.current.event_editEvent,
                          child: EditEventModalView(
                            eventDetails: events[index],
                            teams: state.teams,
                            onPressedSubmit: (event) {
                              searchController.clear();
                              context.read<EventsCubit>().editEvent(event);
                            },
                          ),
                        );
                      },
                      // onPreview: () {
                      //   context.pushNamed(
                      //     AppRoutes.eventDetailsScreen,
                      //     pathParameters: {
                      //       AppArguments.eventDetails: '${events[index].id}',
                      //     },
                      //   );
                      // },
                      // onDelete: () {
                      //   context.read<EventsCubit>().deleteEvent(events[index].id);
                      // },
                      previewButtonTitle: S.current.button_title_preview,
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            events[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
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
                                  text: events[index]
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
                    AppBottomModalSheet.minHeightWithAppBar(
                      header: S.current.event_addEvent,
                      child: AddEventModalView(
                        teams: state.teams,
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
