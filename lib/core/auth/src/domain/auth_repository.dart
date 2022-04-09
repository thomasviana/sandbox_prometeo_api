import 'package:sandbox_prometeo/core/auth/domain.dart';

abstract class AuthRepository {
  Future<RequiredParameters> getRequiredParameters(String bank);
  Stream<AuthResponse> checkAuthStatus(Credentials credentials);
  Future<void> logOut();
}
