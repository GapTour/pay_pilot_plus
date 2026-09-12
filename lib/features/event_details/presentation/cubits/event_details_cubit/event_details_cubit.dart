import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_details_state.dart';
part 'status/fetch_details_status.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final IEventDetailsRepository _repository;

  EventDetailsCubit(this._repository)
    : super(
        EventDetailsState(
          fetchDetailStatus: FetchDetailInitial(),
          allBanks: List.empty(),
          allMenuItems: List.empty(),
          allUsers: List.empty(),
        ),
      );

  Future<void> initEventDetails(String serializedEventInfo) async {
    final eventDetails = EventModel.fromJson(serializedEventInfo);
    final banksResponse = await _fetchAllBanks();
    final usersResponse = await _fetchAllUsers();
    final menuItemsResponse = await _fetchAllMenuItems();

    if (banksResponse == null ||
        usersResponse == null ||
        menuItemsResponse == null) {
      emit(state.copyWith(fetchDetailStatus: FetchDetailFailure()));
      return;
    }

    emit(
      state.copyWith(
        fetchDetailStatus: FetchDetailSuccess(eventDetails),
        allBanks: List.from(banksResponse),
        allUsers: List.from(usersResponse),
        allMenuItems: List.from(menuItemsResponse),
      ),
    );
  }

  Future<List<BankModel>?> _fetchAllBanks() async {
    final dataSate = await _repository.fetchAllBanks();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
  }

  Future<List<UserModel>?> _fetchAllUsers() async {
    final dataSate = await _repository.fetchAllUsers();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
  }

  Future<List<MenuItemModel>?> _fetchAllMenuItems() async {
    final dataSate = await _repository.fetchAllMenuItems();

    if (dataSate.isSuccess) return dataSate.response!;
    return null;
  }
}
