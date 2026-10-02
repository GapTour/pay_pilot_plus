part of 'event_ratios_cubit.dart';

enum RatioFetchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RatioFetchStatus.initial;
  bool get isLoading => this == RatioFetchStatus.loading;
  bool get isSuccess => this == RatioFetchStatus.success;
  bool get isFailure => this == RatioFetchStatus.failure;
}

enum RatioModificationStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RatioModificationStatus.initial;
  bool get isLoading => this == RatioModificationStatus.loading;
  bool get isSuccess => this == RatioModificationStatus.success;
  bool get isFailure => this == RatioModificationStatus.failure;
}

class EventRatiosState extends Equatable {
  final RatioFetchStatus ratioFetchStatus;
  final RatioModificationStatus ratioModificationStatus;
  final List<TeamMemberModel> memberRatios;
  final List<TeamFundModel> fundRatios;
  const EventRatiosState({
    required this.ratioFetchStatus,
    required this.ratioModificationStatus,
    required this.memberRatios,
    required this.fundRatios,
  });

  @override
  List<Object> get props => [
    ratioFetchStatus,
    ratioModificationStatus,
    memberRatios,
    fundRatios,
  ];

  EventRatiosState copyWith({
    RatioFetchStatus? ratioFetchStatus,
    RatioModificationStatus? ratioModificationStatus,
    List<TeamMemberModel>? memberRatios,
    List<TeamFundModel>? fundRatios,
  }) {
    return EventRatiosState(
      ratioFetchStatus: ratioFetchStatus ?? this.ratioFetchStatus,
      ratioModificationStatus:
          ratioModificationStatus ?? this.ratioModificationStatus,
      memberRatios: memberRatios ?? this.memberRatios,
      fundRatios: fundRatios ?? this.fundRatios,
    );
  }
}
