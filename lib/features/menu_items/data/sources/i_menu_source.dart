import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';

abstract class IMenuSource<TMenu, TInt, TList> {
  Future<TMenu> insertItemToMenu(MenuItemParams params);
  Future<TInt> archiveMenu(int id);
  Future<TList> fetchAllMenuItems();
  Future<TMenu> updateMenu(MenuItemParams params);
}
