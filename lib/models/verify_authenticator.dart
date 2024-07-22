import '../services/api_service.dart';
class VerifyAuthenticatorDto implements JsonSerializable {
  final String code;

  VerifyAuthenticatorDto({required this.code});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
