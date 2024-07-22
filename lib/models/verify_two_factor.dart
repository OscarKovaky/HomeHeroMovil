import '../services/api_service.dart';

class VerifyTwoFactorDto implements JsonSerializable {
  final String email;
  final String code;
  final bool rememberMe;

  VerifyTwoFactorDto({required this.email, required this.code, required this.rememberMe});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
      'rememberMe': rememberMe,
    };
  }
}
