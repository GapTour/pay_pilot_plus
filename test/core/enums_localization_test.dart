import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';

void main() {
  Map<String, List<String>> titles() => {
    'group': AccountGroupType.values.map((e) => e.localizedTitle).toList(),
    'general': GeneralAccountType.values.map((e) => e.localizedTitle).toList(),
    'subsidiary': SubsidiaryAccountType.values
        .map((e) => e.localizedTitle)
        .toList(),
    'snacks': SnacksFeeAssignmentStatus.values
        .map((e) => e.localizedTitle)
        .toList(),
    'journal': JournalType.values.map((e) => e.localizedTitle).toList(),
    'registration': RegistrationStatus.values
        .map((e) => e.localizedTitle)
        .toList(),
  };

  test('localized titles exist and differ between fa and en', () async {
    await S.load(const Locale('fa'));
    final fa = titles();
    await S.load(const Locale('en'));
    final en = titles();

    for (final group in fa.keys) {
      expect(fa[group]!.every((t) => t.isNotEmpty), isTrue, reason: group);
      expect(en[group]!.every((t) => t.isNotEmpty), isTrue, reason: group);
      for (var i = 0; i < fa[group]!.length; i++) {
        expect(en[group]![i], isNot(fa[group]![i]), reason: '$group[$i]');
      }
    }
  });

  test('persian localized title matches the stable title', () async {
    await S.load(const Locale('fa'));

    expect(
      SubsidiaryAccountType.values.map((e) => e.localizedTitle),
      SubsidiaryAccountType.values.map((e) => e.title),
    );
    expect(
      GeneralAccountType.values.map((e) => e.localizedTitle),
      GeneralAccountType.values.map((e) => e.title),
    );
    expect(
      AccountGroupType.values.map((e) => e.localizedTitle),
      AccountGroupType.values.map((e) => e.title),
    );
    expect(
      JournalType.values.map((e) => e.localizedTitle),
      JournalType.values.map((e) => e.title),
    );
    expect(
      SnacksFeeAssignmentStatus.values.map((e) => e.localizedTitle),
      SnacksFeeAssignmentStatus.values.map((e) => e.title),
    );
  });

  test('error messages are localized with their values', () async {
    await S.load(const Locale('en'));

    expect(
      S.current.error_duplicateName('Ali'),
      'The name Ali is already taken, please choose another name.',
    );
    expect(
      S.current.error_journalUnbalanced('100', '90'),
      contains('total debit (100)'),
    );
  });
}
