part of 'banks_cubit.dart';

enum BanksStatus { initial, loading, success, failure }

@immutable
class BanksState extends Equatable {
  final BanksStatus banksStatus;
  final List<BankModel> banks;
  final List<BankModel> allBanks;

  const BanksState({
    required this.banksStatus,
    required this.banks,
    required this.allBanks,
  });

  @override
  List<Object> get props => [banksStatus, banks, allBanks];

  BanksState copyWith({
    BanksStatus? banksStatus,
    List<BankModel>? banks,
    List<BankModel>? allBanks,
  }) {
    return BanksState(
      banksStatus: banksStatus ?? this.banksStatus,
      banks: banks ?? this.banks,
      allBanks: allBanks ?? this.allBanks,
    );
  }
}
