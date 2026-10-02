part of 'event_details_cubit.dart';

enum DetailsTabStatus {
  guests,
  orders,
  expenses,
  ratios;

  bool get isGuests => this == .guests;
  bool get isOrders => this == .orders;
  bool get isExpenses => this == .expenses;
  bool get isRatios => this == .ratios;
}

class EventDetailsState extends Equatable {
  final FetchDetailStatus fetchDetailStatus;
  final DetailsTabStatus detailsTabStatus;
  final List<BankModel> allBanks;
  final List<UserModel> allUsers;
  final List<FundModel> allFunds;
  final List<MenuItemModel> allMenuItems;

  const EventDetailsState({
    required this.fetchDetailStatus,
    required this.detailsTabStatus,
    required this.allBanks,
    required this.allUsers,
    required this.allFunds,
    required this.allMenuItems,
  });

  @override
  List<Object> get props {
    return [
      fetchDetailStatus,
      detailsTabStatus,
      allBanks,
      allUsers,
      allFunds,
      allMenuItems,
    ];
  }

  EventDetailsState copyWith({
    FetchDetailStatus? fetchDetailStatus,
    DetailsTabStatus? detailsTabStatus,
    List<BankModel>? allBanks,
    List<UserModel>? allUsers,
    List<FundModel>? allFunds,
    List<MenuItemModel>? allMenuItems,
  }) {
    return EventDetailsState(
      fetchDetailStatus: fetchDetailStatus ?? this.fetchDetailStatus,
      detailsTabStatus: detailsTabStatus ?? this.detailsTabStatus,
      allBanks: allBanks ?? this.allBanks,
      allUsers: allUsers ?? this.allUsers,
      allFunds: allFunds ?? this.allFunds,
      allMenuItems: allMenuItems ?? this.allMenuItems,
    );
  }
}
