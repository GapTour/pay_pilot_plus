import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/app_text_style.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

typedef ItemInfo = ({int id, String name, int accountID});

class AppSelectItemPlusAccountIdModalView extends StatefulWidget {
  final List<ItemInfo> items;
  final Function(({int id, String name, int accountID}) selected) onSelect;

  const AppSelectItemPlusAccountIdModalView({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  State<AppSelectItemPlusAccountIdModalView> createState() =>
      _AppSelectItemPlusAccountIdModalViewState();
}

class _AppSelectItemPlusAccountIdModalViewState
    extends State<AppSelectItemPlusAccountIdModalView> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();
  final filteredItems = <ItemInfo>[];

  void _search(String query) {
    if (query.isEmpty) {
      filteredItems
        ..clear()
        ..addAll(widget.items);
      setState(() {});
      return;
    }

    final filter = widget.items
        .where((m) => m.name.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    filteredItems
      ..clear()
      ..addAll(filter);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _debuncer = DebounceHelper();
    filteredItems.addAll(widget.items);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (filteredItems.isEmpty)
          Center(child: Text('هیچ موردی برای نمایش وجود ندارد'))
        else
          ListView.separated(
            padding: EdgeInsets.only(right: 24, left: 24, top: 85, bottom: 120),
            itemCount: filteredItems.length,
            separatorBuilder: (context, index) => Gap(8),
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return InkWell(
                onTap: () {
                  widget.onSelect((
                    id: item.id,
                    name: item.name,
                    accountID: item.accountID,
                  ));
                  context.pop();
                },
                child: AppTileInRow(
                  parent: Text(
                    item.name,
                    style: AppTextStyle.getRegularStyle(fontSize: 14),
                  ),
                ),
              );
            },
          ),
        Positioned(
          top: 0,
          right: 24,
          left: 24,
          child: AppTextField(
            hint: 'جستجو',
            controller: searchController,
            keyboardType: TextInputType.name,
            onChange: (value) => _debuncer.call(() => _search(value)),
          ),
        ),
      ],
    );
  }
}
