import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/cubits/journals_cubit/journals_cubit.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/creditor_box.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/debtor_box.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/extra_journal_info.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/header_banner.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/journal_text.dart';

class JournalsScreen extends StatefulWidget {
  static const routeName = '/journals';

  const JournalsScreen({super.key});

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  late String serializedHeaderInfo;
  late HeaderModel headerDetails;

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      headerDetails = HeaderModel.fromJson(serializedHeaderInfo);
      context.read<JournalsCubit>().loadJournals(headerDetails.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    serializedHeaderInfo =
        (context.goRouterState
            as Map<String, String>)[AppArguments.serializedHeaderInfo]!;

    return Scaffold(
      appBar: AppBar(title: Text('جزییات سند')),
      body: BlocBuilder<JournalsCubit, JournalsState>(
        buildWhen: (p, c) => p.journalsStatus != c.journalsStatus,
        builder: (context, state) {
          final journals = state.journals;
          final isLoading =
              state.journalsStatus == .loading ||
              state.journalsStatus == .initial;

          if (isLoading) {
            return AppLoadingState();
          }

          return Column(
            children: [
              HeaderBanner(headerDetails: headerDetails),
              Expanded(
                child: AppList(
                  itemCount: journals.length,
                  emptyInboxMessage: S.current.member_emptyStateContent,
                  itemBuilder: (context, index) {
                    final journal = journals[index];

                    return AppTileInRow(
                      parent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 3.5,
                        children: [
                          JournalText(
                            title: 'حساب معین',
                            subtitle: journal.subsidiaryAccount.type.title,
                            suffix: journal.subsidiaryAccount.type.completeCode,
                          ),

                          if (journal.firstDetailedInfo != null)
                            JournalText(
                              title: 'تفضیلی ۱',
                              subtitle: journal.firstDetailedInfo!.name,
                              suffix: journal.firstDetailedInfo!.code,
                            ),
                          if (journal.secondDetailedInfo != null)
                            JournalText(
                              title: 'تفضیلی ۲',
                              subtitle: journal.secondDetailedInfo!.name,
                              suffix: journal.secondDetailedInfo!.code,
                            ),
                          JournalText(
                            title: 'شرح سند',
                            subtitle: journal.memo ?? '***',
                          ),
                          Gap(8),
                          Row(
                            children: [
                              DebtorBox(debitAmount: journal.debit),
                              CreditorBox(creditAmount: journal.credit),
                            ],
                          ),
                          Gap(5),
                        ],
                      ),
                      child: ExtraJournalInfo(journal: journal),
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
