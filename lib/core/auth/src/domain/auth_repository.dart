import 'package:dartz/dartz.dart';
import 'package:sandbox_prometeo/core/auth/domain.dart';

abstract class AuthRepository {
  Future<Option<List<AuthField>>> getAuthFields(String bank);
  Stream<AuthResponse> checkAuthStatus(List<String> credentials);
  Future<void> logOut();
}
