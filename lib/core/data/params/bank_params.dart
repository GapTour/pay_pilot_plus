class BankParams {
  final int? id;
  final String name;
  final String? description;
  final String? number;
  final String? noticeMemo;
  final BigInt? openingBalance;
  final bool isActive;

  BankParams({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
    required this.noticeMemo,
    required this.openingBalance,
    required this.isActive,
  });
}
