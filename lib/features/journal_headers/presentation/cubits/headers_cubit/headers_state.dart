part of 'headers_cubit.dart';

enum HeadersStatus { initial, loading, success, failure }

@immutable
class HeadersState extends Equatable {
  final HeadersStatus headersStatus;
  final List<HeaderModel> headers;
  final List<HeaderModel> allHeaders;

  const HeadersState({
    required this.headersStatus,
    required this.headers,
    required this.allHeaders,
  });

  @override
  List<Object> get props => [headersStatus, headers, allHeaders];

  HeadersState copyWith({
    HeadersStatus? headersStatus,
    List<HeaderModel>? headers,
    List<HeaderModel>? allHeaders,
  }) {
    return HeadersState(
      headersStatus: headersStatus ?? this.headersStatus,
      headers: headers ?? this.headers,
      allHeaders: allHeaders ?? this.allHeaders,
    );
  }
}
