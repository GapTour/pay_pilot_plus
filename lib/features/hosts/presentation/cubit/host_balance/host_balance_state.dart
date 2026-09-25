part of 'host_balance_cubit.dart';

enum BalanceStatus {
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

class HostBalanceState extends Equatable {
  final BigInt remainingAmount;
  final List<JournalLineModel> journals;
  final BalanceStatus balanceStatus;
  final RemainingStatus remainingStatus;
  const HostBalanceState({
    required this.remainingAmount,
    required this.journals,
    required this.balanceStatus,
    required this.remainingStatus,
  });

  @override
  List<Object> get props => [
    remainingAmount,
    journals,
    balanceStatus,
    remainingStatus,
  ];

  HostBalanceState copyWith({
    BigInt? remainingAmount,
    List<JournalLineModel>? journals,
    BalanceStatus? balanceStatus,
    RemainingStatus? remainingStatus,
  }) {
    return HostBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      journals: journals ?? this.journals,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      remainingStatus: remainingStatus ?? this.remainingStatus,
    );
  }
}
