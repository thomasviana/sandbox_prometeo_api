import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/keys/keys.dart';

import '../../domain.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  static const String prometeoUrl = 'https://banking.sandbox.prometeoapi.com';
  static const String prometeoApiKey = PROMETEO_API_KEY;

  @override
  Future<RequiredParameters> getRequiredParameters(String bank) async {
    try {
      final response = await http.get(
        Uri.parse(prometeoUrl + '/provider/test/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-API-Key': prometeoApiKey,
        },
      );
      final parsed = jsonDecode(response.body);
      final requiredParameters = RequiredParameters.fromJson(parsed);
      return Future.value(requiredParameters);
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  @override
  Stream<AuthResponse> checkAuthStatus(Credentials credentials) async* {
    try {
      final response = await http.post(
        Uri.parse(prometeoUrl + '/login/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-API-Key': prometeoApiKey,
        },
        body: {
          'provider': credentials.provider,
          'username': credentials.username,
          'password': credentials.password,
        },
      );
      final authResponse = AuthResponse.fromJson(response.body);
      yield authResponse;
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await http.get(
        Uri.parse(prometeoUrl + '/logout/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'X-API-Key': prometeoApiKey,
        },
      );
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }
}
