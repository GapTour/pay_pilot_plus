import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';

// Future<DataState<T>> safeApiCall<T>(Future<DataState<T>> Function() action) {
//   return _executeSafeCall(
//     action,
//     sourceSpecificMapper: (e) {
//       if (e is DioException) return ErrorResponse.fromDioException(e);
//       return null;
//     },
//   );
// }

Future<DataState<T>> safeDbCall<T>(
  Future<DataState<T>> Function() action,
) async {
  return _executeSafeCall(
    action,
    sourceSpecificMapper: (e) {
      if (e is SqliteException) {
        return _buildError(
          'database_error',
          700 + e.resultCode,
          'sqlite_exception',
          e.message,
        );
      }
      if (e is InvalidDataException) {
        return _buildError(
          'validation_error',
          701,
          'drift_validation',
          e.message,
        );
      }
      if (e is StateError) {
        return _buildError('state_error', 702, 'query_state', e.message);
      }
      return null;
    },
  );
}

Future<DataState<T>> _executeSafeCall<T>(
  Future<DataState<T>> Function() action, {
  required ErrorResponse? Function(Object e) sourceSpecificMapper,
}) async {
  try {
    return await action();
  } catch (e) {
    // 1. Attempt to map domain-specific exceptions (Dio, Drift, etc.)
    final specificError = sourceSpecificMapper(e);
    if (specificError != null) {
      return DataFailed(specificError);
    }

    // 2. Fallback to common Dart language exceptions
    return DataFailed(_mapCommonExceptions(e));
  }
}

ErrorResponse _mapCommonExceptions(Object e) {
  if (e is TypeError) {
    return _buildError('error', 600, 'type_error', e.toString());
  }
  if (e is FormatException) {
    return _buildError('error', 600, 'format_exception', e.message);
  }
  return _buildError('error', 600, 'uncategorized_error', e.toString());
}

ErrorResponse _buildError(
  String status,
  int code,
  String field,
  String errorDetail,
) {
  return ErrorResponse(
    message: 'مشکلی پیش آمده است!',
    status: status,
    code: code,
    fieldErrors: [
      FieldError(field: field, errors: [errorDetail]),
    ],
  );
}
