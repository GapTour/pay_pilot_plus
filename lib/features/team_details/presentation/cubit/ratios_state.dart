part of 'ratios_cubit.dart';

enum TeamRatiosStatus { initial, loading, success, failure }

@immutable
class RatiosState extends Equatable {
  final TeamRatiosStatus teamRatiosStatus;
  final List<FundModel> funds;
  final List<UserModel> members;
  final Map<int, double> addedMembers;
  final Map<int, double> addedFunds;
  final List<TeamMemberModel> memberRatios;
  final List<TeamFundModel> fundRatios;

  const RatiosState({
    required this.teamRatiosStatus,
    required this.funds,
    required this.members,
    required this.addedMembers,
    required this.addedFunds,
    required this.memberRatios,
    required this.fundRatios,
  });

  @override
  List<Object> get props {
    return [
      teamRatiosStatus,
      funds,
      members,
      addedMembers,
      addedFunds,
      memberRatios,
      fundRatios,
    ];
  }

  RatiosState copyWith({
    TeamRatiosStatus? teamRatiosStatus,
    List<FundModel>? funds,
    List<UserModel>? members,
    Map<int, double>? addedMembers,
    Map<int, double>? addedFunds,
    List<TeamMemberModel>? memberRatios,
    List<TeamFundModel>? fundRatios,
  }) {
    return RatiosState(
      teamRatiosStatus: teamRatiosStatus ?? this.teamRatiosStatus,
      funds: funds ?? this.funds,
      members: members ?? this.members,
      addedMembers: addedMembers ?? this.addedMembers,
      addedFunds: addedFunds ?? this.addedFunds,
      memberRatios: memberRatios ?? this.memberRatios,
      fundRatios: fundRatios ?? this.fundRatios,
    );
  }
}
