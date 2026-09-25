part of 'guests_cubit.dart';

enum GuestsStatus { initial, loading, success, failure }

@immutable
class GuestsState extends Equatable {
  final GuestsStatus guestsStatus;
  final List<UserModel> guests;
  final List<UserModel> allGuests;

  const GuestsState({
    required this.guestsStatus,
    required this.guests,
    required this.allGuests,
  });

  @override
  List<Object> get props => [guestsStatus, guests, allGuests];

  GuestsState copyWith({
    GuestsStatus? guestsStatus,
    List<UserModel>? guests,
    List<UserModel>? allGuests,
  }) {
    return GuestsState(
      guestsStatus: guestsStatus ?? this.guestsStatus,
      guests: guests ?? this.guests,
      allGuests: allGuests ?? this.allGuests,
    );
  }
}
