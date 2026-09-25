part of 'members_cubit.dart';

enum MembersStatus { initial, loading, success, failure }

@immutable
class MembersState extends Equatable {
  final MembersStatus membersStatus;
  final List<UserModel> members;
  final List<UserModel> allMembers;

  const MembersState({
    required this.membersStatus,
    required this.members,
    required this.allMembers,
  });

  @override
  List<Object> get props => [membersStatus, members, allMembers];

  MembersState copyWith({
    MembersStatus? membersStatus,
    List<UserModel>? members,
    List<UserModel>? allMembers,
  }) {
    return MembersState(
      membersStatus: membersStatus ?? this.membersStatus,
      members: members ?? this.members,
      allMembers: allMembers ?? this.allMembers,
    );
  }
}
