class BankModel {
  final int bankID;
  final int detailedAccountID;
  final String accountCode;
  final String accountName;
  final String name;
  final String? description;
  final String? number;
  final bool isActive;

  BankModel({
    required this.bankID,
    required this.detailedAccountID,
    required this.accountCode,
    required this.accountName,
    required this.name,
    required this.description,
    required this.number,
    required this.isActive,
  });
}
