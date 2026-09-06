import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';

sealed class DataState<T> {
  final T? response;
  final ErrorResponse? error;

  const DataState(this.response, this.error);

  bool get isSuccess => this is DataSuccess<T>;
  bool get isFailed => this is DataFailed<T>;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? response) : super(response, null);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ErrorResponse error) : super(null, error);
}
