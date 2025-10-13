import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handle(DioException e) {
    if (e.response != null) {
      return Failure("Received invalid status code: ${e.response!.statusCode}");
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ClientError("Connection timeout. Check your internet.");
      case DioExceptionType.receiveTimeout:
        return ClientError("Server took too long to respond.");
      case DioExceptionType.sendTimeout:
        return ClientError("Request timed out while sending data.");
      case DioExceptionType.unknown:
        return ClientError("Unexpected network error.");
      case DioExceptionType.cancel:
        return ClientError("Request was cancelled.");
      default:
        return Failure(e.message ?? "Unknown network error occurred");
    }
  }
}
