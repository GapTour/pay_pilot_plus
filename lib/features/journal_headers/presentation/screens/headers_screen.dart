import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/cubits/headers_cubit/headers_cubit.dart';

class HeadersScreen extends StatefulWidget {
  static const routeName = '/headers';

  const HeadersScreen({super.key});

  @override
  State<HeadersScreen> createState() => _HeadersScreenState();
}

class _HeadersScreenState extends State<HeadersScreen> {
  late DebounceHelper _debuncer;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<HeadersCubit>().loadHeaders();
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
      appBar: AppBar(title: Text('اسناد حسابداری')),
      body: BlocBuilder<HeadersCubit, HeadersState>(
        buildWhen: (p, c) => p.headersStatus != c.headersStatus,
        builder: (context, state) {
          final headers = state.headers;
          final isLoading =
              state.headersStatus == .loading ||
              state.headersStatus == .initial;

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
                    () => context.read<HeadersCubit>().searchHeader(value),
                  ),
                ),
              ),
              Expanded(
                child: AppList(
                  itemCount: headers.length,
                  emptyInboxMessage: 'هیچ سندی یافت نشد!',
                  itemBuilder: (context, index) {
                    return AppTileInRow(
                      onPreview: () {
                        context.pushNamed(
                          AppRoutes.journalsScreen,
                          extra: {
                            AppArguments.serializedHeaderInfo: headers[index]
                                .toJson(),
                          },
                        );
                      },
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headers[index]
                                .entryDate
                                .formattedToJalali_yearMonthDay,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Gap(8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'نوع سند   ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                                TextSpan(
                                  text: headers[index].type.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium,
                                ),
                              ],
                            ),
                          ),
                          Gap(8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'توضیحات   ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                                TextSpan(
                                  text: headers[index].description,
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
    );
  }
}
