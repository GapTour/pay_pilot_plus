import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';

/// Base repository encapsulating standardized exception handling across
/// local database operations and remote data sources.
abstract class BaseRepository {
  const BaseRepository();

  /// Executes a database operation within a unified error-handling context.
  ///
  /// Wrap data provider calls that return raw models or entities here.
  /// Uncaught database exceptions are caught and mapped directly to a [DataFailed] state.
  @protected
  Future<DataState<T>> safeDbCall<T>(Future<T> Function() action) async {
    return _executeSafeCall(
      action,
      sourceSpecificMapper: _mapDatabaseException,
    );
  }

  /// Low-level safe execution wrapper handling domain-specific and common Dart exceptions.
  Future<DataState<T>> _executeSafeCall<T>(
    Future<T> Function() action, {
    required ErrorResponse? Function(Object e) sourceSpecificMapper,
  }) async {
    try {
      final result = await action();
      return DataSuccess<T>(result);
    } catch (e) {
      // 1. Attempt source-specific exception resolution (Drift/Sqlite, Dio, etc.)
      final specificError = sourceSpecificMapper(e);
      if (specificError != null) {
        return DataFailed<T>(specificError);
      }

      // 2. Fallback to general system and language exceptions
      return DataFailed<T>(_mapCommonExceptions(e));
    }
  }

  /// Maps Drift and SQLite database specific exceptions to structured domain errors.
  ErrorResponse? _mapDatabaseException(Object e) {
    if (e is SqliteException) {
      return _buildError(
        status: 'database_error',
        code: 700 + e.resultCode,
        field: 'sqlite_exception',
        errorDetail: e.message,
      );
    }
    if (e is InvalidDataException) {
      return _buildError(
        status: 'validation_error',
        code: 701,
        field: 'drift_validation',
        errorDetail: e.message,
      );
    }
    if (e is StateError) {
      return _buildError(
        status: 'state_error',
        code: 702,
        field: 'query_state',
        errorDetail: e.message,
      );
    }
    return null;
  }

  /// Maps unexpected runtime Dart errors.
  ErrorResponse _mapCommonExceptions(Object e) {
    if (e is TypeError) {
      return _buildError(
        status: 'error',
        code: 600,
        field: 'type_error',
        errorDetail: e.toString(),
      );
    }
    if (e is FormatException) {
      return _buildError(
        status: 'error',
        code: 600,
        field: 'format_exception',
        errorDetail: e.message,
      );
    }
    return _buildError(
      status: 'error',
      code: 600,
      field: 'uncategorized_error',
      errorDetail: e.toString(),
    );
  }

  /// Factory helper for creating standardized API/Domain error payloads.
  ErrorResponse _buildError({
    required String status,
    required int code,
    required String field,
    required String errorDetail,
  }) {
    return ErrorResponse(
      message: S.current.error_generic,
      status: status,
      code: code,
      fieldErrors: [
        FieldError(field: field, errors: [errorDetail]),
      ],
    );
  }
}
