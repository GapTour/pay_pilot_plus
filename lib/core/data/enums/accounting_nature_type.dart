enum AccountingNatureType {
  debitNature,
  creditNature,
  mixedNature;

  bool get hasDebitNature => this == .debitNature;
  bool get hasCreditNature => this == .creditNature;
  bool get hasMixedNature => this == .mixedNature;
}
