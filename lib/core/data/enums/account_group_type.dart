part of '../../database/app_database.dart';

enum AccountGroupType {
  assets('10', 'دارایی‌ها'),
  liabilities('20', 'بدهی‌ها'),
  equity('30', 'سرمایه'),
  revenues('40', 'درآمدها'),
  expenses('50', 'هزینه‌ها');

  final String prefix;
  final String title;

  const AccountGroupType(this.prefix, this.title);

  factory AccountGroupType.fromPrefix(String prefix) {
    return AccountGroupType.values.firstWhere(
      (type) => type.prefix == prefix,
      orElse: () => throw ArgumentError('Invalid prefix: $prefix'),
    );
  }

  factory AccountGroupType.fromTitle(String title) {
    return AccountGroupType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => throw ArgumentError('Invalid title: $title'),
    );
  }
}
