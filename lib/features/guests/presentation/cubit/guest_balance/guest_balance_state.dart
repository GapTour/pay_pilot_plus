part of 'guest_balance_cubit.dart';

enum BalanceStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == .loading || this == .initial;
  bool get isFailure => this == .failure;
  bool get isSuccess => this == .success;
}

typedef RegistrationTotals = ({
  int count,
  BigInt gross,
  BigInt discount,
  BigInt net,
});

enum RemainingStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == .loading || this == .initial;
  bool get isFailure => this == .failure;
}

class GuestBalanceState extends Equatable {
  final BigInt remainingAmount;
  final List<JournalLineModel> journals;
  final BalanceStatus balanceStatus;
  final RemainingStatus remainingStatus;
  final List<GuestRegistration> registrations;
  final BalanceStatus registrationsStatus;
  final Set<int> selectedIDs;
  const GuestBalanceState({
    required this.remainingAmount,
    required this.journals,
    required this.balanceStatus,
    required this.remainingStatus,
    required this.registrations,
    required this.registrationsStatus,
    this.selectedIDs = const {},
  });

  /// ثبت‌نام‌های لغوشده در خلاصه حساب نمی‌شوند
  Iterable<GuestRegistration> get activeRegistrations =>
      registrations.where((e) => !e.status.isCancelled);

  RegistrationTotals get activeTotals => _sum(activeRegistrations);

  /// جمع تیک‌خورده‌ها؛ لغوشده‌ها هم اگر انتخاب شوند حساب می‌شوند
  RegistrationTotals get selectedTotals =>
      _sum(registrations.where((e) => selectedIDs.contains(e.id)));

  static RegistrationTotals _sum(Iterable<GuestRegistration> items) {
    return items.fold(
      (count: 0, gross: BigInt.zero, discount: BigInt.zero, net: BigInt.zero),
      (t, e) => (
        count: t.count + 1,
        gross: t.gross + e.grossAmount,
        discount: t.discount + e.discountAmount,
        net: t.net + e.netAmount,
      ),
    );
  }

  @override
  List<Object> get props => [
    remainingAmount,
    journals,
    balanceStatus,
    remainingStatus,
    registrations,
    registrationsStatus,
    selectedIDs,
  ];

  GuestBalanceState copyWith({
    BigInt? remainingAmount,
    List<JournalLineModel>? journals,
    BalanceStatus? balanceStatus,
    RemainingStatus? remainingStatus,
    List<GuestRegistration>? registrations,
    BalanceStatus? registrationsStatus,
    Set<int>? selectedIDs,
  }) {
    return GuestBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      journals: journals ?? this.journals,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      remainingStatus: remainingStatus ?? this.remainingStatus,
      registrations: registrations ?? this.registrations,
      registrationsStatus: registrationsStatus ?? this.registrationsStatus,
      selectedIDs: selectedIDs ?? this.selectedIDs,
    );
  }
}
