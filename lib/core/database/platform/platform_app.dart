// lib/core/database/platform/platform_app.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// REPLACES kDebugMode
const _isDebugMode = !bool.fromEnvironment('dart.vm.product');

class PlatformInterface {
  static QueryExecutor createDatabaseConnection(String databaseName) {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, '$databaseName.sqlite'));
      return NativeDatabase(file, logStatements: _isDebugMode);
    });
  }

  static Future<File> databaseFile(String databaseName) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(join(dir.path, '$databaseName.sqlite'));
  }
}
