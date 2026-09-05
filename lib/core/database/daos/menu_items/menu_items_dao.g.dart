// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_items_dao.dart';

// ignore_for_file: type=lint
mixin _$MenuItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MenuItemsTable get menuItems => attachedDatabase.menuItems;
  MenuItemsDaoManager get managers => MenuItemsDaoManager(this);
}

class MenuItemsDaoManager {
  final _$MenuItemsDaoMixin _db;
  MenuItemsDaoManager(this._db);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db.attachedDatabase, _db.menuItems);
}
