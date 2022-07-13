import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/keys/keys.dart';

import '../../domain.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  static const String prometeoUrl = 'https://banking.sandbox.prometeoapi.com';
  static const String prometeoApiKey = PROMETEO_API_KEY;

  String _provider = 'test';
  List<AuthField> _authFields = [];
  @override
  Future<Option<List<AuthField>>> getAuthFields(String bank) async {
    try {
      final response = await http.get(
        Uri.parse(prometeoUrl + '/provider/$bank/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-API-Key': prometeoApiKey,
        },
      );
      final status = jsonDecode(response.body)['status'] as String;
      if (status == 'error') {
        return const None();
      } else {
        final parsed =
            jsonDecode(response.body)['provider']['auth_fields'] as List;
        final authFields = parsed.map((e) => AuthField.fromMap(e)).toList();
        _provider = bank;
        _authFields = authFields;
        return some(authFields);
      }
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  @override
  Stream<AuthResponse> checkAuthStatus(List<String> credentials) async* {
    try {
      final response = await http.post(Uri.parse(prometeoUrl + '/login/'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-API-Key': prometeoApiKey,
          },
          body: buildBodyFromFields(credentials));
      final authResponse = AuthResponse.fromJson(response.body);
      yield authResponse;
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  Map<String, String> buildBodyFromFields(List<String> credentials) {
    Map<String, String> body = {'provider': _provider};
    for (var i = 0; i < _authFields.length; i++) {
      body.putIfAbsent(_authFields[i].name, () => credentials[i]);
    }
    return body;
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
