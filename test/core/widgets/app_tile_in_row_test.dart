import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

void main() {
  Future<Color> shadowOf(WidgetTester tester, {Color? shadowColor}) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: Scaffold(
          body: AppTileInRow(parent: const Text('x'), shadowColor: shadowColor),
        ),
      ),
    );

    final box = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(AppTileInRow),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    return (box.decoration as BoxDecoration).boxShadow!.single.color;
  }

  testWidgets('uses the given shadow color', (tester) async {
    expect(
      await shadowOf(tester, shadowColor: appTheme.colorScheme.primary),
      appTheme.colorScheme.primary,
    );
  });

  testWidgets('falls back to outlineVariant', (tester) async {
    expect(await shadowOf(tester), appTheme.colorScheme.outlineVariant);
  });
}
