import '../../domain/entity/api_response_entity.dart';

class ApiResponseModel<T> extends ApiResponseEntity<T> {
  ApiResponseModel({
    required super.success,
    required super.message,
    super.data,
    super.error,
    super.status,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    String? errorMsg;
    int? errorStatus;

    if (json['data'] != null && json['success'] == false) {
      final dataObj = json['data'];
      errorMsg = dataObj['error'];
      errorStatus = dataObj['status'];
    }

    dynamic parsedData;
    if (json['data'] != null && json['success'] == true) {
      parsedData = fromJsonT(json['data']);
    }

    return ApiResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: parsedData,
      error: errorMsg,
      status: errorStatus,
    );
  }
}
