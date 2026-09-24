// lib/core/database/platform/platform_web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

// REPLACES kReleaseMode
const _isReleaseMode = bool.fromEnvironment('dart.vm.product');

class PlatformInterface {
  static QueryExecutor createDatabaseConnection(String databaseName) {
    return DatabaseConnection.delayed(
      Future(() async {
        final database = await WasmDatabase.open(
          databaseName: databaseName,
          sqlite3Uri: Uri.parse('/sqlite3.wasm'),
          driftWorkerUri: Uri.parse(
            _isReleaseMode ? '/worker.dart.min.js' : '/worker.dart.js',
          ),
        );
        return database.resolvedExecutor;
      }),
    );
  }
}
