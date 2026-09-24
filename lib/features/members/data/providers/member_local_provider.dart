import 'package:collection/collection.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_opening_journals_helper.dart';
import 'package:pay_pilot_plus/features/members/data/sources/i_member_source.dart';

abstract class IMemberLocalProvider
    implements IMemberSource<UserModel, int, List<UserModel>> {}

class MemberLocalProvider implements IMemberLocalProvider {
  final UsersDao _usersDao;
  final DetailedAccountsDao _accountsDao;
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;

  MemberLocalProvider(
    this._usersDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._journalsDao,
  );

  @override
  Future<int> archiveMember(int id) async {
    final userAccount = await _accountsDao.fetchUserAccount(id);
    await _accountsDao.archiveAccount(userAccount.id);

    return await _usersDao.archiveUser(id);
  }

  @override
  Future<UserModel> insertMember(UserParams params) async {
    final userID = await _usersDao.insertUser(params);

    final accountParams = DetailedAccountParams(
      id: null,
      attachmentID: userID,
      name: params.name.trim(),
      type: .user,
    );
    final newAccount = await _accountsDao.insertAccount(accountParams);

    if (params.openingBalance != null) {
      final subsidiariesMap = await _subsidiaryAccountsDao
          .fetchSubsidiaryAccounts();

      final openingJournals = RecordOpeningJournalsHelper.submitMemberPayable(
        userInfo: (
          id: userID,
          name: params.name.trim(),
          accountID: newAccount.id,
        ),
        subsidiaryAccountsMap: subsidiariesMap,
        openingAmount: params.openingBalance!,
      );

      await _journalsDao.insertOpeningJournal(openingJournals);
    }

    return UserModel(
      id: userID,
      detailedAccountInfo: (
        id: newAccount.id,
        code: newAccount.code,
        name: params.name.trim(),
      ),
      name: params.name.trim(),
      birthday: params.birthday,
      description: params.description,
      instagramID: params.instagramID,
      phoneNumber: params.phone,
      isActive: true,
      profileImage: params.profileImage,
      telegramID: params.telegramID,
      role: params.role,
      openingBalance: params.openingBalance ?? BigInt.zero,
    );
  }

  @override
  Future<UserModel> updateMember(UserParams params) async {
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

    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    await _journalsDao.deleteOpeningJournals(
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.accountsPayable]!.id,
      firstDetailedId: detailedAccount.id,
    );

    if (params.openingBalance != null) {
      final openingJournals = RecordOpeningJournalsHelper.submitMemberPayable(
        userInfo: (
          id: params.id!,
          name: params.name.trim(),
          accountID: detailedAccount.id,
        ),
        subsidiaryAccountsMap: subsidiariesMap,
        openingAmount: params.openingBalance!,
      );

      await _journalsDao.insertOpeningJournal(openingJournals);
    }

    return UserModel(
      id: params.id!,
      detailedAccountInfo: (
        id: detailedAccount.id,
        code: detailedAccount.code,
        name: detailedAccount.name,
      ),
      name: params.name.trim(),
      birthday: params.birthday,
      description: params.description,
      instagramID: params.instagramID,
      phoneNumber: params.phone,
      isActive: params.isActive,
      profileImage: params.profileImage,
      telegramID: params.telegramID,
      role: params.role,
      openingBalance: params.openingBalance ?? BigInt.zero,
    );
  }

  @override
  Future<List<UserModel>> fetchAllMembers() async {
    final result = await _usersDao.fetchAllActiveStaffs();
    final openingLines = await _journalsDao.fetchAllOpeningJournals();

    return result.map((e) {
      final user = e.user;
      final account = e.account;
      final openingInfo = openingLines?.firstWhereOrNull((e) {
        return e.firstDetailedId == account.id && e.credit != BigInt.zero;
      });

      return UserModel(
        id: user.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        name: user.name,
        description: user.description,
        phoneNumber: user.phoneNumber,
        isActive: user.isActive,
        profileImage: user.profileImage,
        telegramID: user.telegramId,
        instagramID: user.instagramId,
        birthday: user.birthday,
        role: user.role,
        openingBalance: openingInfo?.credit ?? BigInt.zero,
      );
    }).toList();
  }
}
