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
import 'package:pay_pilot_plus/features/menu_items/presentation/cubit/menu_items_cubit.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/widgets/add_menu_item_modal_view.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/widgets/edit_menu_item_modal_view.dart';

class MenuItemsScreen extends StatefulWidget {
  static const routeName = '/menu-items';

  const MenuItemsScreen({super.key});

  @override
  State<MenuItemsScreen> createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<MenuItemsCubit>().loadItems();
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
      appBar: AppBar(title: Text(S.current.menu_appBarTitle)),
      body: BlocBuilder<MenuItemsCubit, MenuItemsState>(
        buildWhen: (p, c) => p.menuItemsStatus != c.menuItemsStatus,
        builder: (context, state) {
          final items = state.items;
          final isLoading =
              state.menuItemsStatus == .loading ||
              state.menuItemsStatus == .initial;

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
                    () => context.read<MenuItemsCubit>().searchItem(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: items.length,
                  emptyInboxMessage: S.current.menu_emptyStateContent,
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
                          header: S.current.menu_editItem,
                          child: EditMenuItemModalView(
                            item: items[index],
                            onPressedSubmit: (t) {
                              searchController.clear();
                              context.read<MenuItemsCubit>().updateItem(t);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        searchController.clear();
                        context.read<MenuItemsCubit>().deleteItem(
                          items[index].id,
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].title,
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
            header: S.current.menu_addItem,
            child: AddMenuItemModalView(
              onPressedSubmit: (user) {
                searchController.clear();
                context.read<MenuItemsCubit>().addItem(user);
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
