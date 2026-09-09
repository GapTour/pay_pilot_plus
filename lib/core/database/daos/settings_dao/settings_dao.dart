import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/platform/platform.dart'
    as platform;
import 'package:sqlite3/sqlite3.dart' show sqlite3;

part 'settings_dao.g.dart';

@DriftAccessor(tables: [
  ],
)
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<File> exportSqliteBackup() async {
    final dir = await getTemporaryDirectory();

    final timestamp = DateTime.now()
        .toUtc()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');

    final file = File('${dir.path}/pay-pilot-backup-$timestamp.sqlite');

    if (await file.exists()) {
      await file.delete();
    }

    await db.customStatement('VACUUM INTO ?', [file.path]);

    return file;
  }

  Future<void> importSqliteBackup(PlatformFile backupFile) async {
    final targetFile = await platform.Platform.databaseFile(
      'pay-pilot-plus-db',
    );
    final backupDb = sqlite3.open(backupFile.xFile.path);

    // Vacuum it into a temporary location first to make sure it's working.
    final tempPath = await getTemporaryDirectory();
    final tempDb = join(tempPath.path, 'import.db');
    backupDb
      ..execute('VACUUM INTO ?', [tempDb])
      ..close();

    // Then replace the existing database file with it.
    final tempDbFile = File(tempDb);
    await tempDbFile.copy(targetFile.path);
    await tempDbFile.delete();
  }
}
