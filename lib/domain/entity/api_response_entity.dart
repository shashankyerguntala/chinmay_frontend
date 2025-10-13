class ApiResponseEntity<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;
  final int? status;

  ApiResponseEntity({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.status,
  });
}
