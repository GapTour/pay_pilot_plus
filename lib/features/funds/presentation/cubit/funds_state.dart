part of 'funds_cubit.dart';

enum FundStatus { initial, loading, success, failure }

@immutable
class FundsState extends Equatable {
  final FundStatus fundStatus;
  final List<FundModel> funds;
  final List<FundModel> allFunds;
  const FundsState({
    required this.fundStatus,
    required this.funds,
    required this.allFunds,
  });

  @override
  List<Object> get props => [fundStatus, funds, allFunds];

  FundsState copyWith({
    FundStatus? fundStatus,
    List<FundModel>? funds,
    List<FundModel>? allFunds,
  }) {
    return FundsState(
      fundStatus: fundStatus ?? this.fundStatus,
      funds: funds ?? this.funds,
      allFunds: allFunds ?? this.allFunds,
    );
  }
}
