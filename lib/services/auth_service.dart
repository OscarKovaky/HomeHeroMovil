import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/login.dart';
import '../models/verify_two_factor.dart';
import '../models/verify_authenticator.dart';
import '../models/base_response.dart';
import 'api_service.dart';

class AuthService extends ApiService<BaseResponse> {
  AuthService() : super('');

  Future<Map<String, dynamic>> login(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginDto.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> verifyTwoFactor(VerifyTwoFactorDto verifyTwoFactorDto) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/verify-2fa'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(verifyTwoFactorDto.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify two-factor authentication');
    }
  }

  Future<Map<String, dynamic>> enableTwoFactor(String token) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/enable-2fa'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to enable two-factor authentication');
    }
  }

  Future<void> verifyAuthenticator(String token, VerifyAuthenticatorDto verifyAuthenticatorDto) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/verify-authenticator'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(verifyAuthenticatorDto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to verify authenticator');
    }
  }

  @override
  BaseResponse fromJson(Map<String, dynamic> json) {
    return BaseResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BaseResponse item) {
    return item.toJson();
  }
}