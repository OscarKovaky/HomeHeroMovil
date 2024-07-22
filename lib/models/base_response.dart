import '../services/api_service.dart';

class BaseResponse implements JsonSerializable {
  final bool success;
  final String message;

  BaseResponse({required this.success, required this.message});

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
