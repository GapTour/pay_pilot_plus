part of 'event_details_cubit.dart';

class EventDetailsState extends Equatable {
  final FetchDetailStatus fetchDetailStatus;
  final List<BankModel> allBanks;
  final List<UserModel> allUsers;
  final List<MenuItemModel> allMenuItems;
  const EventDetailsState({
    required this.fetchDetailStatus,
    required this.allBanks,
    required this.allUsers,
    required this.allMenuItems,
  });

  @override
  List<Object> get props => [
    fetchDetailStatus,
    allBanks,
    allUsers,
    allMenuItems,
  ];

  EventDetailsState copyWith({
    FetchDetailStatus? fetchDetailStatus,
    List<BankModel>? allBanks,
    List<UserModel>? allUsers,
    List<MenuItemModel>? allMenuItems,
  }) {
    return EventDetailsState(
      fetchDetailStatus: fetchDetailStatus ?? this.fetchDetailStatus,
      allBanks: allBanks ?? this.allBanks,
      allUsers: allUsers ?? this.allUsers,
      allMenuItems: allMenuItems ?? this.allMenuItems,
    );
  }
}
