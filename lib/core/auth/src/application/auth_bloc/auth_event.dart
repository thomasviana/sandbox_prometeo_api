part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthRequiredParametersRequested extends AuthEvent {}

class AuthStatusRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class ProviderChanged extends AuthEvent {
  final String provider;
  ProviderChanged({
    required this.provider,
  });
}

class UsernameChanged extends AuthEvent {
  final String username;
  UsernameChanged({
    required this.username,
  });
}

class PasswordChanged extends AuthEvent {
  final String password;
  PasswordChanged({
    required this.password,
  });
}
