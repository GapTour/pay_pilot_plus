import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

typedef SimpleReportTopic = ({String title, String description, String route});

class SimpleReportsScreen extends StatelessWidget {
  static const routeName = '/simple-reports';

  const SimpleReportsScreen({super.key});

  /// موضوع‌های جدید (هزینه‌ها، درآمد رویدادها و ...) به این لیست اضافه می‌شوند
  List<SimpleReportTopic> get _topics => [
    (
      title: S.current.simpleReport_memberSalaries,
      description: S.current.simpleReport_salaryDescription,
      route: AppRoutes.salaryReportScreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.button_title_simpleReports)),
      body: AppList(
        padding: const EdgeInsets.all(20.0),
        itemCount: _topics.length,
        emptyInboxMessage: S.current.simpleReport_empty,
        itemBuilder: (context, index) {
          final topic = _topics[index];

          return AppTileInRow(
            onPreview: () => context.pushNamed(topic.route),
            parent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  topic.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
