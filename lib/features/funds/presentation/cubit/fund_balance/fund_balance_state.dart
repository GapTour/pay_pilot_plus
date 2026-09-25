part of 'fund_balance_cubit.dart';

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
  bool get isSuccess => this == .success;
}

class FundBalanceState extends Equatable {
  final BigInt remainingAmount;
  final FundStatus fundStatus;
  final List<FundBalanceModel> funds;
  final RemainingStatus remainingStatus;
  const FundBalanceState({
    required this.remainingAmount,
    required this.fundStatus,
    required this.funds,
    required this.remainingStatus,
  });

  @override
  List<Object> get props => [
    remainingAmount,
    fundStatus,
    funds,
    remainingStatus,
  ];

  FundBalanceState copyWith({
    BigInt? remainingAmount,
    FundStatus? fundStatus,
    List<FundBalanceModel>? funds,
    RemainingStatus? remainingStatus,
  }) {
    return FundBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      fundStatus: fundStatus ?? this.fundStatus,
      funds: funds ?? this.funds,
      remainingStatus: remainingStatus ?? this.remainingStatus,
    );
  }
}
