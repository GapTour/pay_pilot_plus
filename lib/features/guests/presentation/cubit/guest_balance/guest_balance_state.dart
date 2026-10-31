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
  const GuestBalanceState({
    required this.remainingAmount,
    required this.journals,
    required this.balanceStatus,
    required this.remainingStatus,
    required this.registrations,
    required this.registrationsStatus,
  });

  /// ثبت‌نام‌های لغوشده در خلاصه حساب نمی‌شوند
  Iterable<GuestRegistration> get activeRegistrations =>
      registrations.where((e) => !e.status.isCancelled);

  BigInt get totalGross =>
      activeRegistrations.fold(BigInt.zero, (sum, e) => sum + e.grossAmount);

  BigInt get totalDiscount =>
      activeRegistrations.fold(BigInt.zero, (sum, e) => sum + e.discountAmount);

  BigInt get totalNet =>
      activeRegistrations.fold(BigInt.zero, (sum, e) => sum + e.netAmount);

  @override
  List<Object> get props => [
    remainingAmount,
    journals,
    balanceStatus,
    remainingStatus,
    registrations,
    registrationsStatus,
  ];

  GuestBalanceState copyWith({
    BigInt? remainingAmount,
    List<JournalLineModel>? journals,
    BalanceStatus? balanceStatus,
    RemainingStatus? remainingStatus,
    List<GuestRegistration>? registrations,
    BalanceStatus? registrationsStatus,
  }) {
    return GuestBalanceState(
      remainingAmount: remainingAmount ?? this.remainingAmount,
      journals: journals ?? this.journals,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      remainingStatus: remainingStatus ?? this.remainingStatus,
      registrations: registrations ?? this.registrations,
      registrationsStatus: registrationsStatus ?? this.registrationsStatus,
    );
  }
}
