import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'menu_items_dao.g.dart';

@DriftAccessor(tables: [MenuItems])
class MenuItemsDao extends DatabaseAccessor<AppDatabase>
    with _$MenuItemsDaoMixin {
  MenuItemsDao(super.db);

  Future<int> insertItemToMenu(MenuItemParams params) async {
    return await transaction(() async {
      return await into(menuItems)
          .insert(MenuItemsCompanion(title: Value(params.title)));
    });
  }

  Future<List<MenuItem>> fetchAllMenuItems() async {
    return await (select(
      menuItems,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  Future<MenuItem> fetchItemFromMenu(int id) async {
    return await (select(
      menuItems,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateMenuItem(MenuItemParams params) async {
    return await transaction(() async {
      return await (update(
        menuItems,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        MenuItemsCompanion(
          title: Value(params.title),
          isActive: Value(params.isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> archiveMenu(int id) async {
    return await transaction(() async {
      return await (update(menuItems)..where((tbl) => tbl.id.equals(id))).write(
        MenuItemsCompanion(
          isActive: Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  // Future<void> deleteItem(int id) async {
  //   await (delete(menuItems)..where((tbl) => tbl.id.equals(id))).go();
  // }
}
