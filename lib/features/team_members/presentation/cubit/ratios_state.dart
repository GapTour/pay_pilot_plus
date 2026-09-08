part of 'ratios_cubit.dart';

enum TeamMemberStatus { initial, loading, success, failure }

@immutable
class RatiosState extends Equatable {
  final TeamMemberStatus teamMemberStatus;
  final List<UserModel> members;
  final Map<int, double> addedMembers;
  final List<TeamMemberModel> ratios;

  const RatiosState({
    required this.teamMemberStatus,
    required this.members,
    required this.addedMembers,
    required this.ratios,
  });

  @override
  List<Object> get props => [teamMemberStatus, members, addedMembers, ratios];

  RatiosState copyWith({
    TeamMemberStatus? teamMemberStatus,
    List<UserModel>? members,
    Map<int, double>? addedMembers,
    List<TeamMemberModel>? ratios,
  }) {
    return RatiosState(
      teamMemberStatus: teamMemberStatus ?? this.teamMemberStatus,
      members: members ?? this.members,
      addedMembers: addedMembers ?? this.addedMembers,
      ratios: ratios ?? this.ratios,
    );
  }
}
