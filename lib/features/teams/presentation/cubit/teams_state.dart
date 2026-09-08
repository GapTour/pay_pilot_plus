part of 'teams_cubit.dart';

enum TeamsStatus { initial, loading, success, failure }

@immutable
class TeamsState extends Equatable {
  final TeamsStatus teamsStatus;
  final List<TeamModel> teams;
  final List<TeamModel> allTeams;

  const TeamsState({
    required this.teamsStatus,
    required this.teams,
    required this.allTeams,
  });

  @override
  List<Object> get props => [teamsStatus, teams, allTeams];

  TeamsState copyWith({
    TeamsStatus? teamsStatus,
    List<TeamModel>? teams,
    List<TeamModel>? allTeams,
  }) {
    return TeamsState(
      teamsStatus: teamsStatus ?? this.teamsStatus,
      teams: teams ?? this.teams,
      allTeams: allTeams ?? this.allTeams,
    );
  }
}
