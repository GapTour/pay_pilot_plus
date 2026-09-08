import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/features/guests/data/sources/i_guest_source.dart';

abstract class IGuestLocalProvider
    implements IGuestSource<UserModel, int, List<UserModel>> {}

class GuestLocalProvider implements IGuestLocalProvider {
  final UsersDao _usersDao;
  final DetailedAccountsDao _accountsDao;

  GuestLocalProvider(this._usersDao, this._accountsDao);

  @override
  Future<int> archiveGuest(int id) async {
    final userAccount = await _accountsDao.fetchUserAccount(id);
    await _accountsDao.archiveAccount(userAccount.id);

    return await _usersDao.archiveUser(id);
  }

  @override
  Future<UserModel> insertGuest(UserParams params) async {
    final userID = await _usersDao.insertUser(params);

    final accountParams = DetailedAccountParams(
      id: null,
      attachmentID: userID,
      name: params.name.trim(),
      type: .user,
    );
    final newAccount = await _accountsDao.insertAccount(accountParams);

    return UserModel(
      userID: userID,
      detailedAccountID: newAccount.id,
      accountCode: newAccount.code,
      accountName: params.name.trim(),
      name: params.name.trim(),
      birthday: params.birthday,
      description: params.description,
      instagramID: params.instagramID,
      phoneNumber: params.phone,
      isActive: true,
      profileImage: params.profileImage,
      telegramID: params.telegramID,
      role: params.role,
    );
  }

  @override
  Future<UserModel> updateGuest(UserParams params) async {
    await _usersDao.updateUser(params);

    final detailedAccount = await _accountsDao.fetchUserAccount(params.id!);
    final updateAccountParams = DetailedAccountParams(
      id: detailedAccount.id,
      attachmentID: detailedAccount.userID,
      name: params.name.trim(),
      type: .user,
      isActive: params.isActive,
    );
    await _accountsDao.updateAccount(updateAccountParams);

    return UserModel(
      userID: params.id!,
      detailedAccountID: detailedAccount.id,
      accountCode: detailedAccount.code,
      accountName: params.name.trim(),
      name: params.name.trim(),
      birthday: params.birthday,
      description: params.description,
      instagramID: params.instagramID,
      phoneNumber: params.phone,
      isActive: params.isActive,
      profileImage: params.profileImage,
      telegramID: params.telegramID,
      role: params.role,
    );
  }

  @override
  Future<List<UserModel>> fetchAllGuests() async {
    final result = await _usersDao.fetchAllActiveGuests();

    return result.map((e) {
      final user = e.user;
      final account = e.account;

      return UserModel(
        userID: user.id,
        detailedAccountID: account.id,
        accountCode: account.code,
        accountName: account.name,
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
}
