import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/app_text_style.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

typedef ItemInfo = ({int id, String name});

class AppSelectRawItemModalView extends StatefulWidget {
  final List<ItemInfo> items;
  final Function(({int id, String name}) selected) onSelect;

  const AppSelectRawItemModalView({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  State<AppSelectRawItemModalView> createState() =>
      _AppSelectRawItemModalViewState();
}

class _AppSelectRawItemModalViewState extends State<AppSelectRawItemModalView> {
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
          Center(child: Text(S.current.common_noItemToShow))
        else
          ListView.separated(
            padding: EdgeInsets.only(right: 24, left: 24, top: 85, bottom: 120),
            itemCount: filteredItems.length,
            separatorBuilder: (context, index) => Gap(8),
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return InkWell(
                onTap: () {
                  widget.onSelect((id: item.id, name: item.name));
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
            hint: S.current.textField_hint_search,
            controller: searchController,
            keyboardType: TextInputType.name,
            onChange: (value) => _debuncer.call(() => _search(value)),
          ),
        ),
      ],
    );
  }
}
