import 'package:cross_file/cross_file.dart' as xfile;
import 'package:pay_pilot_plus/core/utils/helpers/pick_file_helper.dart';
import 'package:pay_pilot_plus/core/utils/services/database_backup_service.dart';
import 'package:pay_pilot_plus/features/settings/data/sources/i_setting_source.dart';
import 'package:share_plus/share_plus.dart';

abstract class ISettingLocalProvider
    implements ISettingSource<ShareParams, bool> {}

class SettingLocalProvider implements ISettingLocalProvider {
  final DatabaseBackupService _backupService;
  SettingLocalProvider(this._backupService);

  @override
  Future<ShareParams> createNativeBackup() async {
    final backupFile = await _backupService.exportSqliteBackup();

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
      await _backupService.importSqliteBackup(pickDataState.response!);
    }

    if (pickDataState.isFailed) return false;

    return true;
  }
}
