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

  /// عنوان قابل ترجمه برای نمایش در رابط کاربری؛ `title` ثابت می‌ماند
  /// چون برای سریال‌سازی و نام حساب‌های ذخیره‌شده استفاده می‌شود.
  String get localizedTitle => switch (this) {
    assets => S.current.accountGroup_assets,
    liabilities => S.current.accountGroup_liabilities,
    equity => S.current.accountGroup_equity,
    revenues => S.current.accountGroup_revenues,
    expenses => S.current.accountGroup_expenses,
  };

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
