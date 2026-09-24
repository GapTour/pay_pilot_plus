import 'dart:io';

import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:path/path.dart' as p;
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
    final backupPath = backupFile.path;
    if (backupPath == null) {
      throw Exception('Source backup file path is inaccessible.');
    }

    final sourceFile = File(backupPath);
    if (!await sourceFile.exists()) {
      throw Exception(
        'Source file does not exist or access is blocked by the OS.',
      );
    }

    final targetFile = await platform.Platform.databaseFile(
      'pay-pilot-plus-db',
    );
    final temporaryDirectory = await getTemporaryDirectory();

    final localBackupFile = File(
      p.join(temporaryDirectory.path, 'local_backup.db'),
    );
    final temporaryDatabaseFile = File(
      p.join(temporaryDirectory.path, 'import.db'),
    );

    if (!await localBackupFile.parent.exists()) {
      await localBackupFile.parent.create(recursive: true);
    }

    // 2. Code 14 Root Cause Fix: SQLite throws SQLITE_CANTOPEN (14)
    // if the target file of a `VACUUM INTO` already exists.
    final writeSink = localBackupFile.openWrite();
    await sourceFile.openRead().pipe(writeSink);

    if (await temporaryDatabaseFile.exists()) {
      await temporaryDatabaseFile.delete();
    }

    try {
      final backupDatabase = sqlite3.open(localBackupFile.path);
      backupDatabase
        ..execute('VACUUM INTO ?', [temporaryDatabaseFile.path])
        ..close();
    } finally {
      if (await localBackupFile.exists()) {
        await localBackupFile.delete();
      }
    }

    // 4. Safely apply the processed db to the target location.
    if (await temporaryDatabaseFile.exists()) {
      if (!await targetFile.parent.exists()) {
        await targetFile.parent.create(recursive: true);
      }
      await temporaryDatabaseFile.copy(targetFile.path);
      await temporaryDatabaseFile.delete();
    } else {
      throw Exception('Failed to generate optimized database backup.');
    }
  }
}
