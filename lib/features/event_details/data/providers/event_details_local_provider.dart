import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_details_source.dart';

abstract class IEventDetailsLocalProvider
    implements
        IEventDetailsSource<
          List<BankModel>,
          List<UserModel>,
          List<FundModel>,
          List<MenuItemModel>
        > {}

class EventDetailsLocalProvider extends BaseRepository
    implements IEventDetailsLocalProvider {
  final UsersDao _usersDao;
  final BanksDao _banksDao;
  final MenuItemsDao _menuItemsDao;
  final FundsDao _fundsDao;

  EventDetailsLocalProvider(
    this._banksDao,
    this._menuItemsDao,
    this._usersDao,
    this._fundsDao,
  );

  @override
  Future<List<BankModel>> fetchAllBanks() async {
    final result = await _banksDao.fetchAllActiveBanks();

    return result.map((e) {
      final bank = e.bank;
      final account = e.account;

      return BankModel(
        id: bank.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        openingBalance: BigInt.zero,
        name: bank.name,
        description: bank.description,
        isActive: bank.isActive,
        number: bank.number,
      );
    }).toList();
  }

  @override
  Future<List<MenuItemModel>> fetchAllMenuItems() async {
    final result = await _menuItemsDao.fetchAllActiveMenuItems();

    return result.map((e) {
      return MenuItemModel(id: e.id, title: e.title, isActive: e.isActive);
    }).toList();
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final result = await _usersDao.fetchAllActiveUsers();

    return result.map((e) {
      final user = e.user;
      final account = e.account;

      return UserModel(
        id: user.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        openingBalance: BigInt.zero,
        name: user.name,
        description: user.description,
        phoneNumber: user.phoneNumber,
        isActive: user.isActive,
        profileImage: user.profileImage,
        telegramID: user.telegramId,
        instagramID: user.instagramId,
        birthday: user.birthday,
        role: user.role,
      );
    }).toList();
  }

  @override
  Future<List<FundModel>> fetchAllFunds() async {
    final result = await _fundsDao.fetchAllActiveFunds();

    return result.map((e) {
      return FundModel(
        id: e.id,
        title: e.title,
        openingBalance: BigInt.zero,
        isActive: e.isActive,
      );
    }).toList();
  }
}
