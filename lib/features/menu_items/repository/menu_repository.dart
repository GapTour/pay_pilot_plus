import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/menu_items/data/providers/menu_local_provider.dart';
import 'package:pay_pilot_plus/features/menu_items/data/sources/i_menu_source.dart';

abstract class IMenuRepository
    implements
        IMenuSource<
          DataState<MenuItemModel>,
          DataState<int>,
          DataState<List<MenuItemModel>>
        > {}

class MenuRepository extends BaseRepository implements IMenuRepository {
  final IMenuLocalProvider _localProvider;

  MenuRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveMenu(int id) {
    return safeDbCall(() => _localProvider.archiveMenu(id));
  }

  @override
  Future<DataState<List<MenuItemModel>>> fetchAllMenuItems() {
    return safeDbCall(() => _localProvider.fetchAllMenuItems());
  }

  @override
  Future<DataState<MenuItemModel>> insertItemToMenu(MenuItemParams params) {
    return safeDbCall(() => _localProvider.insertItemToMenu(params));
  }

  @override
  Future<DataState<MenuItemModel>> updateMenu(MenuItemParams params) {
    return safeDbCall(() => _localProvider.updateMenu(params));
  }
}
