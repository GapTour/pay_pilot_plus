// پیش‌نمایش بصری تم: ویجت‌های اصلی برنامه با فونت واقعی، راست‌به‌چپ و فارسی.
// برای ساخت دوباره تصاویر:
//   flutter test test/goldens --update-goldens
// تصاویر به سیستم‌عامل وابسته‌اند؛ روی ماشین دیگر ممکن است چند پیکسل فرق کنند.
@Tags(['golden'])
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/core/data/models/salary_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_colors.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_balance_description.dart';
import 'package:pay_pilot_plus/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_hidden_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_secondary_elevated_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/widgets/header_banner.dart';
import 'package:pay_pilot_plus/features/reports/presentation/widgets/report_summary_banner.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/member_salary_tile.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_banner.dart';

Future<void> _loadFonts() async {
  final iran = FontLoader('IranSansX');
  for (final w in ['Regular', 'Medium', 'Bold']) {
    iran.addFont(rootBundle.load('assets/fonts/IRANSansX-$w.ttf'));
  }
  await iran.load();

  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  final icons = File(
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (flutterRoot != null && icons.existsSync()) {
    final bytes = icons.readAsBytesSync();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(Future.value(ByteData.view(bytes.buffer)))).load();
  }
}

final _subsidiary = SubsidiaryModel(
  id: 1,
  accountGroup: (id: 2, type: AccountGroupType.liabilities),
  generalAccount: (id: 4, type: GeneralAccountType.accountsPayable),
  type: SubsidiaryAccountType.accountsPayable,
);

DetailedAccountModel _detailed(int id, String code, String name) =>
    DetailedAccountModel(
      id: id,
      code: code,
      name: name,
      type: DetailedAccountType.user,
      userInfo: null,
      eventInfo: null,
      bankInfo: null,
      isActive: true,
    );

final _journal = JournalLineModel(
  id: 1,
  headerID: 1,
  subsidiaryAccount: _subsidiary,
  firstDetailedInfo: _detailed(1, '1000001', 'مهدیار ارباب‌زی'),
  secondDetailedInfo: _detailed(2, '2000001', 'رویداد تحلیل فیلم'),
  debit: BigInt.zero,
  credit: BigInt.from(2500000),
  series: 'SR-1405-0012',
  noticeMemo: null,
  memo: 'بابت حقوق رویداد تحلیل فیلم',
);

final _summary = MemberSalarySummaryModel(
  memberInfo: (id: 1, name: 'زینب جدیدی', code: '1000002'),
  totalSalary: BigInt.from(4750000),
  currentBalance: BigInt.from(1200000),
  items: [
    SalaryItemModel(
      id: 1,
      memberInfo: (id: 1, name: 'زینب جدیدی', code: '1000002'),
      eventInfo: (id: 1, name: 'تحلیل فیلم'),
      amount: BigInt.from(4750000),
      date: DateTime(2026, 3, 1),
    ),
  ],
);

Widget _section(String title) => Builder(
  builder: (context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
    child: Text('— $title', style: const TextStyle(color: Colors.grey)),
  ),
);

Widget _page(List<Widget> children) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: appTheme,
  themeMode: ThemeMode.dark,
  locale: const Locale('fa'),
  supportedLocales: const [Locale('fa'), Locale('en')],
  localizationsDelegates: const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(
    appBar: AppBar(title: const Text('گزارش‌های ساده')),
    body: ListView(children: children),
  ),
);

Future<void> _shoot(WidgetTester tester, String name, List<Widget> body) async {
  await tester.binding.setSurfaceSize(const Size(420, 1600));
  await tester.pumpWidget(_page(body));
  await tester.pump(const Duration(milliseconds: 300));
  await expectLater(find.byType(MaterialApp), matchesGoldenFile('$name.png'));
}

void main() {
  setUpAll(() async {
    await _loadFonts();
    await S.load(const Locale('fa'));
  });

  testWidgets('tiles and journals', (tester) async {
    await _shoot(tester, 'gallery_1_tiles', [
      _section('Text() بدون استایل'),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('متن پیش‌فرض بدون استایل ۱۲۳٬۴۵۶'),
      ),
      _section('AppTileInRow'),
      AppTileInRow(
        onPreview: () {},
        parent: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تیم فیلم', style: Theme.of(context).textTheme.titleMedium),
              Text('توضیحات   ', style: Theme.of(context).textTheme.labelLarge),
              Text(
                'شرح کوتاه تیم',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      _section('AppTile'),
      AppTile(
        onPreview: () {},
        child: Builder(
          builder: (context) => Text(
            'رویداد تحلیل فیلم',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      _section('AppJournalTile'),
      AppJournalTile(journal: _journal),
      _section('AppJournalHiddenTile'),
      AppJournalHiddenTile(
        journal: _journal,
        debitTitle: 'پرداختی',
        creditTitle: 'پرداخت نشده',
      ),
      _section('AppList (خالی)'),
      const SizedBox(
        height: 80,
        child: AppList(
          itemCount: 0,
          itemBuilder: _noItem,
          emptyInboxMessage: 'هنوز عضوی اضافه نشده است!',
        ),
      ),
    ]);
  });

  testWidgets('forms buttons dialogs', (tester) async {
    await _shoot(tester, 'gallery_2_forms', [
      _section('AppTextField'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppTextField(label: 'نام', hint: 'مهدیار'),
            const SizedBox(height: 12),
            AppTextField(
              label: 'تاریخ',
              hint: '۱۴۰۵/۰۱/۰۱',
              readOnly: true,
              suffixIcon: Icons.arrow_drop_down_circle_rounded,
            ),
          ],
        ),
      ),
      _section('AppElevatedButton / AppSecondaryElevatedButton'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppElevatedButton(
              onTap: () {},
              child: Builder(
                builder: (context) => Center(
                  child: Text(
                    'گزارش‌ها',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppSecondaryElevatedButton(
              onTap: () {},
              child: const Center(child: Text('ثبت')),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text('تایید')),
            TextButton(onPressed: () {}, child: const Text('انصراف')),
          ],
        ),
      ),
      _section('رنگ خطا (colorScheme.error)'),
      Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '• الزامی — خطا در دریافت گزارش!',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      _section('AppBalanceDescription'),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AppBalanceDescription(
          plusNote: 'نشان دهنده مقدار طلبی است که میتوان از شخص دریافت کرد.',
          minesNote:
              'نشان دهنده ی مقدار بدهی است که باید به این شخص پرداخت شود.',
        ),
      ),
      _section('AppDialogBox'),
      AppDialogBox(
        title: 'حذف عضو',
        onPressed: () {},
        children: const [Text('درباره انجام این عملیات اطمینان دارید؟')],
      ),
    ]);
  });

  testWidgets('reports and banners', (tester) async {
    await _shoot(tester, 'gallery_3_reports', [
      _section('HeaderBanner'),
      HeaderBanner(
        headerDetails: HeaderModel(
          id: 1,
          entryNumber: 'JV-0042',
          entryDate: DateTime(2026, 3, 1),
          description: 'شناسایی حقوق اعضا بابت رویداد تحلیل فیلم',
          type: JournalType.normal,
          createdAt: DateTime(2026, 3, 1),
        ),
      ),
      _section('ReportSummaryBanner'),
      ReportSummaryBanner(
        totalDebit: BigInt.from(12500000),
        totalCredit: BigInt.from(9800000),
        balance: BigInt.from(2700000),
        linesCount: 18,
      ),
      _section('SimpleReportBanner'),
      SimpleReportBanner(
        title: 'زینب جدیدی',
        rows: const [
          (title: 'جمع حقوق', value: '4,750,000'),
          (title: 'وضعیت حساب', value: 'از گروه طلب دارد: 1,200,000'),
        ],
      ),
      _section('MemberSalaryTile'),
      MemberSalaryTile(summary: _summary, onPreview: () {}),
    ]);
  });

  testWidgets('surfaces and states', (tester) async {
    await _shoot(tester, 'gallery_4_states', [
      _section('سربرگ نارنجی صفحه گردش حساب'),
      Builder(
        builder: (context) {
          final cs = Theme.of(context).colorScheme;
          final tt = Theme.of(context).textTheme;
          return Container(
            color: cs.primary,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'زینب جدیدی',
                        style: tt.bodyLarge?.copyWith(color: cs.onPrimary),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Text(
                          '1,200,000  +',
                          style: tt.bodyLarge?.copyWith(color: cs.primary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'مبلغ افتتاحیه  ',
                        style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                      ),
                      TextSpan(
                        text: '500,000',
                        style: tt.bodyMedium?.copyWith(color: cs.onPrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const AppBalanceDescription(
                  plusNote: 'نشان دهنده مقدار طلبی است.',
                  minesNote: 'نشان دهنده مقدار بدهی است.',
                ),
              ],
            ),
          );
        },
      ),
      _section('سطوح (surface → surfaceContainerHighest)'),
      Builder(
        builder: (context) {
          final cs = Theme.of(context).colorScheme;
          return Row(
            children: [
              for (final c in [
                cs.surface,
                cs.surfaceContainerLow,
                cs.surfaceContainer,
                cs.surfaceContainerHigh,
                cs.surfaceContainerHighest,
              ])
                Expanded(
                  child: Container(
                    height: 56,
                    color: c,
                    alignment: Alignment.center,
                    child: Text('متن', style: TextStyle(color: cs.onSurface)),
                  ),
                ),
            ],
          );
        },
      ),
      _section('رنگ‌های وضعیت'),
      Builder(
        builder: (context) {
          final cs = Theme.of(context).colorScheme;
          final st = AppStatusColors.of(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'خطا: مبلغ نامعتبر است',
                  style: TextStyle(color: cs.error),
                ),
                Text('موفق: سند ثبت شد', style: TextStyle(color: st.success)),
                Text(
                  'هشدار: سند تراز نیست',
                  style: TextStyle(color: st.warning),
                ),
              ],
            ),
          );
        },
      ),
      _section('AppLoadingState'),
      const SizedBox(height: 60, child: AppLoadingState()),
      _section('AlertDialog استاندارد'),
      AlertDialog(
        title: const Text('حذف سند'),
        content: const Text('درباره انجام این عملیات اطمینان دارید؟'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('انصراف')),
          ElevatedButton(onPressed: () {}, child: const Text('تایید')),
        ],
      ),
    ]);
  });
}

Widget? _noItem(BuildContext context, int index) => null;
