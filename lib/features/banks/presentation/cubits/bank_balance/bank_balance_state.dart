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
  final List<UserModel> allUsers;
  final List<FundModel> allFunds;
  final List<EventModel> allEvents;
  const BankBalanceState({
    required this.remainingAmount,
    required this.journals,
    required this.balanceStatus,
    required this.fundStatus,
    required this.funds,
    required this.remainingStatus,
    required this.allUsers,
    required this.allFunds,
    required this.allEvents,
  });

  @override
  List<Object> get props => [
    remainingAmount,
    journals,
    balanceStatus,
    fundStatus,
    funds,
    remainingStatus,
    allUsers,
    allFunds,
    allEvents,
  ];

  BankBalanceState copyWith({
    BigInt? remainingAmount,
    List<JournalLineModel>? journals,
    BalanceStatus? balanceStatus,
    RemainingStatus? remainingStatus,
    FundStatus? fundStatus,
    List<({BigInt amount, String title})>? funds,
    List<UserModel>? allUsers,
    List<FundModel>? allFunds,
    List<EventModel>? allEvents,
  }) {
    return BankBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      journals: journals ?? this.journals,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      remainingStatus: remainingStatus ?? this.remainingStatus,
      fundStatus: fundStatus ?? this.fundStatus,
      funds: funds ?? this.funds,
      allUsers: allUsers ?? this.allUsers,
      allFunds: allFunds ?? this.allFunds,
      allEvents: allEvents ?? this.allEvents,
    );
  }
}
