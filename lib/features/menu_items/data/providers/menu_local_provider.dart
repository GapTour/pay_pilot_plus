import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/features/menu_items/data/sources/i_menu_source.dart';

abstract class IMenuLocalProvider
    implements IMenuSource<MenuItemModel, int, List<MenuItemModel>> {}

class MenuLocalProvider implements IMenuLocalProvider {
  final MenuItemsDao _itemsDao;

  MenuLocalProvider(this._itemsDao);

  @override
  Future<int> archiveMenu(int id) async {
    return await _itemsDao.archiveMenu(id);
  }

  @override
  Future<List<MenuItemModel>> fetchAllMenuItems() async {
    final result = await _itemsDao.fetchAllMenuItems();

    return result.map((e) {
      return MenuItemModel(id: e.id, title: e.title, isActive: e.isActive);
    }).toList();
  }

  @override
  Future<MenuItemModel> insertItemToMenu(MenuItemParams params) async {
    final itemID = await _itemsDao.insertItemToMenu(params);

    return MenuItemModel(id: itemID, title: params.title, isActive: true);
  }

  @override
  Future<MenuItemModel> updateMenu(MenuItemParams params) async {
    final itemID = await _itemsDao.updateMenuItem(params);

    return MenuItemModel(
      id: itemID,
      title: params.title,
      isActive: params.isActive,
    );
  }
}
