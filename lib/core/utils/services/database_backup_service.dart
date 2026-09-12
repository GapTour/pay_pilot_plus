import 'dart:io';

import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/platform/platform.dart'
    as platform;
import 'package:sqlite3/sqlite3.dart' show sqlite3;

class DatabaseBackupService {
  const DatabaseBackupService(this.database);

  final AppDatabase database;

  Future<File> exportSqliteBackup() async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now()
        .toUtc()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');

    final backupFile = File(
      '${directory.path}/pay-pilot-backup-$timestamp.sqlite',
    );

    if (await backupFile.exists()) {
      await backupFile.delete();
    }

    await database.customStatement('VACUUM INTO ?', [backupFile.path]);
    return backupFile;
  }

  Future<void> importSqliteBackup(PlatformFile backupFile) async {
    final targetFile = await platform.Platform.databaseFile(
      'pay-pilot-plus-db',
    );
    final temporaryDirectory = await getTemporaryDirectory();
    final temporaryDatabasePath = join(temporaryDirectory.path, 'import.db');

    final backupDatabase = sqlite3.open(backupFile.xFile.path);
    try {
      backupDatabase.execute('VACUUM INTO ?', [temporaryDatabasePath]);
    } finally {
      backupDatabase.close();
    }

    final temporaryDatabaseFile = File(temporaryDatabasePath);
    await temporaryDatabaseFile.copy(targetFile.path);
    await temporaryDatabaseFile.delete();
  }
}
