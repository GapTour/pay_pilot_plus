class ErrorResponseFields {
  static const String message = 'message';
  static const String status = 'status';
  static const String code = 'code';
  static const String data = 'data';
}

class ErrorResponse {
  ErrorResponse({
    this.message,
    this.status,
    this.code,
    required this.fieldErrors,
  });

  final String? message;
  final String? status;
  final int? code;
  final List<FieldError> fieldErrors;

  factory ErrorResponse.fromDefault({String? errorMessage, int? code}) {
    return ErrorResponse(
      message: 'مشکلی پیش آمده است!',
      status: 'error',
      code: code,
      fieldErrors: [
        FieldError(
          field: 'error',
          errors: [errorMessage ?? 'مشکلی پیش آمده است!'],
        ),
      ],
    );
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataMap =
        json[ErrorResponseFields.data] is Map<String, dynamic>
        ? json[ErrorResponseFields.data]
        : {};

    final List<FieldError> fields = [];
    if (dataMap.isNotEmpty) {
      for (final item in dataMap.entries) {
        if (item.value is List) {
          fields.add(FieldError.fromJson(item.key, item.value));
        }
      }
    }
    if (fields.isEmpty) {
      fields.add(
        FieldError(
          field: json[ErrorResponseFields.status],
          errors: [json[ErrorResponseFields.message]],
        ),
      );
    }

    return ErrorResponse(
      message: json[ErrorResponseFields.message],
      status: json[ErrorResponseFields.status],
      code: json[ErrorResponseFields.code],
      fieldErrors: fields,
    );
  }

  // factory ErrorResponse.fromDioException(DioException e) {
  //   if ((e.response?.statusCode ?? 1000) > 500 ||
  //       e.response?.data is! Map<String, dynamic>) {
  //     return ErrorResponse.fromDefault();
  //   }

  //   return ErrorResponse.fromJson(e.response!.data as Map<String, dynamic>);
  // }
}

class FieldError {
  FieldError({required this.field, required this.errors});

  final String field;
  final List<String> errors;

  factory FieldError.fromJson(String field, List<dynamic> jsonList) {
    final List<String> parsedErrors = jsonList
        .map((e) => e.toString())
        .toList();

    return FieldError(field: field, errors: parsedErrors);
  }
}
