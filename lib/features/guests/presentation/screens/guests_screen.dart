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
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guests/guests_cubit.dart';
import 'package:pay_pilot_plus/features/guests/presentation/widgets/add_guest_modal_view.dart';
import 'package:pay_pilot_plus/features/members/presentation/widgets/edit_member_modal_view.dart';

class GuestsScreen extends StatefulWidget {
  static const routeName = '/guests';

  const GuestsScreen({super.key});

  @override
  State<GuestsScreen> createState() => _GuestsScreenState();
}

class _GuestsScreenState extends State<GuestsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<GuestsCubit>().loadGuests();
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
      appBar: AppBar(title: Text(S.current.guest_appBarTitle)),
      body: BlocBuilder<GuestsCubit, GuestsState>(
        buildWhen: (p, c) => p.guestsStatus != c.guestsStatus,
        builder: (context, state) {
          final guests = state.guests;
          final isLoading =
              state.guestsStatus == GuestsStatus.loading ||
              state.guestsStatus == GuestsStatus.initial;

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
                    () => context.read<GuestsCubit>().searchGuest(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: guests.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.guestBalanceScreen,
                          extra: {
                            AppArguments.serializedUserInfo: guests[index]
                                .toJson(),
                          },
                        );
                      },
                      onEdit: () {
                        AppBottomModalSheet.maxHeightWithAppBar(
                          header: S.current.guest_editGuest,
                          child: EditMemberModalView(
                            member: guests[index],
                            onPressedSubmit: (user) {
                              searchController.clear();
                              context.read<GuestsCubit>().updateGuest(user);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<GuestsCubit>().deleteGuest(
                          guests[index].id,
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guests[index].name,
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
            header: S.current.guest_addGuest,
            child: AddGuestModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<GuestsCubit>().addGuest(user);
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
