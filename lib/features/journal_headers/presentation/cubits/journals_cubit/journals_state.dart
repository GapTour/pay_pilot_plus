part of 'journals_cubit.dart';

enum JournalsStatus { initial, loading, success, failure }

@immutable
class JournalsState extends Equatable {
  final JournalsStatus journalsStatus;
  final List<JournalLineModel> journals;

  const JournalsState({required this.journalsStatus, required this.journals});

  @override
  List<Object> get props => [journalsStatus, journals];

  JournalsState copyWith({
    JournalsStatus? journalsStatus,
    List<JournalLineModel>? journals,
  }) {
    return JournalsState(
      journalsStatus: journalsStatus ?? this.journalsStatus,
      journals: journals ?? this.journals,
    );
  }
}
