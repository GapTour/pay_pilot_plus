part of 'bank_balance_cubit.dart';

enum BalanceStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == .loading || this == .initial;
  bool get isFailure => this == .failure;
  bool get isSuccess => this == .success;
}

enum FundStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == .loading || this == .initial;
  bool get isFailure => this == .failure;
  bool get isSuccess => this == .success;
}

enum RemainingStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == .loading || this == .initial;
  bool get isFailure => this == .failure;
}

class BankBalanceState extends Equatable {
  final BigInt remainingAmount;
  final List<JournalLineModel> journals;
  final BalanceStatus balanceStatus;
  final FundStatus fundStatus;
  final List<({BigInt amount, String title})> funds;
  final RemainingStatus remainingStatus;
  const BankBalanceState({
    required this.remainingAmount,
    required this.journals,
    required this.balanceStatus,
    required this.fundStatus,
    required this.funds,
    required this.remainingStatus,
  });

  @override
  List<Object> get props => [
    remainingAmount,
    journals,
    balanceStatus,
    fundStatus,
    funds,
    remainingStatus,
  ];

  BankBalanceState copyWith({
    BigInt? remainingAmount,
    List<JournalLineModel>? journals,
    BalanceStatus? balanceStatus,
    RemainingStatus? remainingStatus,
    FundStatus? fundStatus,
    List<({BigInt amount, String title})>? funds,
  }) {
    return BankBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      journals: journals ?? this.journals,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      remainingStatus: remainingStatus ?? this.remainingStatus,
      fundStatus: fundStatus ?? this.fundStatus,
      funds: funds ?? this.funds,
    );
  }
}
