part of 'menu_items_cubit.dart';

enum MenuItemsStatus { initial, loading, success, failure }

@immutable
class MenuItemsState extends Equatable {
  final MenuItemsStatus menuItemsStatus;
  final List<MenuItemModel> items;
  final List<MenuItemModel> allItems;

  const MenuItemsState({
    required this.menuItemsStatus,
    required this.items,
    required this.allItems,
  });

  @override
  List<Object> get props => [menuItemsStatus, items, allItems];

  MenuItemsState copyWith({
    MenuItemsStatus? menuItemsStatus,
    List<MenuItemModel>? items,
    List<MenuItemModel>? allItems,
  }) {
    return MenuItemsState(
      menuItemsStatus: menuItemsStatus ?? this.menuItemsStatus,
      items: items ?? this.items,
      allItems: allItems ?? this.allItems,
    );
  }
}
