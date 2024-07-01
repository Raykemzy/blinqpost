class BaseResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  BaseResponse({required this.success, this.data, this.message});
}