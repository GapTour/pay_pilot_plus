import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/app_text_style.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

class AppSelectUserModalView extends StatefulWidget {
  final List<UserModel> users;
  final Function(({int id, String name}) selected) onSelect;

  const AppSelectUserModalView({
    super.key,
    required this.users,
    required this.onSelect,
  });

  @override
  State<AppSelectUserModalView> createState() => _AppSelectUserModalViewState();
}

class _AppSelectUserModalViewState extends State<AppSelectUserModalView> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();
  final filteredMembers = <UserModel>[];

  void _search(String query) {
    if (query.isEmpty) {
      filteredMembers
        ..clear()
        ..addAll(widget.users);
      setState(() {});
      return;
    }

    final filter = widget.users
        .where((m) => m.name.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    filteredMembers
      ..clear()
      ..addAll(filter);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _debuncer = DebounceHelper();
    filteredMembers.addAll(widget.users);
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
        if (filteredMembers.isEmpty)
          Center(child: Text('هیچ موردی برای نمایش وجود ندارد'))
        else
          ListView.separated(
            padding: EdgeInsets.only(right: 24, left: 24, top: 85, bottom: 120),
            itemCount: filteredMembers.length,
            separatorBuilder: (context, index) => Gap(8),
            itemBuilder: (context, index) {
              final member = filteredMembers[index];

              return InkWell(
                onTap: () {
                  widget.onSelect((id: member.userID, name: member.name));
                  context.pop();
                },
                child: AppTileInRow(
                  parent: Text(
                    member.name,
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
