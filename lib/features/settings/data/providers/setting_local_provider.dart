import 'package:cross_file/cross_file.dart' as xfile;
import 'package:pay_pilot_plus/core/database/daos/settings_dao/settings_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/pick_file_helper.dart';
import 'package:pay_pilot_plus/features/settings/data/sources/i_setting_source.dart';
import 'package:share_plus/share_plus.dart';

abstract class ISettingLocalProvider
    implements ISettingSource<ShareParams, bool> {}

class SettingLocalProvider implements ISettingLocalProvider {
  final SettingsDao _settingsDao;
  SettingLocalProvider(this._settingsDao);

  @override
  Future<ShareParams> createNativeBackup() async {
    final backupFile = await _settingsDao.exportSqliteBackup();

    final params = ShareParams(
      title: 'Share Backup File',
      files: [
        xfile.XFile(
          backupFile.path,
          mimeType: 'application/vnd.sqlite3',
          name: backupFile.uri.pathSegments.last,
        ),
      ],
    );

    return params;
  }

  @override
  Future<bool> restoreNativeBackup() async {
    final pickDataState = await PickFileHelper.pickSqliteFile();
    if (pickDataState.isSuccess) {
      await _settingsDao.importSqliteBackup(pickDataState.response!);
    }

    if (pickDataState.isFailed) return false;

    return true;
  }
}
