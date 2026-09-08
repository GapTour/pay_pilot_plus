import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/features/menu_items/repository/menu_repository.dart';

part 'menu_items_state.dart';

class MenuItemsCubit extends Cubit<MenuItemsState> {
  final IMenuRepository _repository;
  MenuItemsCubit(this._repository)
    : super(MenuItemsState(menuItemsStatus: .initial, items: [], allItems: []));

  void loadItems() async {
    emit(state.copyWith(menuItemsStatus: .loading));

    final dataState = await _repository.fetchAllMenuItems();

    if (dataState.isSuccess) {
      final allItems = dataState.response!;

      allItems.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      emit(
        state.copyWith(
          menuItemsStatus: .success,
          items: allItems,
          allItems: allItems,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(menuItemsStatus: .failure));
    }
  }

  void addItem(MenuItemParams params) async {
    final allItems = state.allItems;
    emit(state.copyWith(menuItemsStatus: .loading));

    final dataState = await _repository.insertItemToMenu(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allItems
        ..add(newMember)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          menuItemsStatus: .success,
          allItems: allItems,
          items: allItems,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(menuItemsStatus: .failure));
    }
  }

  void updateItem(MenuItemParams params) async {
    final allItems = state.allItems;
    emit(state.copyWith(menuItemsStatus: .loading));

    final dataState = await _repository.updateMenu(params);

    if (dataState.isSuccess) {
      final newMember = dataState.response!;

      allItems
        ..removeWhere((element) => element.id == newMember.id)
        ..add(newMember)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(
        state.copyWith(
          menuItemsStatus: .success,
          allItems: allItems,
          items: allItems,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(menuItemsStatus: .failure));
    }
  }

  void deleteItem(int teamID) async {
    final allItems = state.allItems;
    emit(state.copyWith(menuItemsStatus: .loading));

    final dataState = await _repository.archiveMenu(teamID);

    if (dataState.isSuccess) {
      allItems.removeWhere((element) => element.id == teamID);

      emit(
        state.copyWith(
          menuItemsStatus: .success,
          allItems: allItems,
          items: allItems,
        ),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(menuItemsStatus: .failure));
    }
  }

  void searchItem(String query) {
    emit(state.copyWith(menuItemsStatus: .loading));
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      emit(state.copyWith(menuItemsStatus: .success, items: state.allItems));
      return;
    }

    final filteredMembers = state.allItems.where((h) {
      return h.title.toLowerCase().contains(normalizedQuery);
    }).toList();

    emit(state.copyWith(menuItemsStatus: .success, items: filteredMembers));
  }
}
