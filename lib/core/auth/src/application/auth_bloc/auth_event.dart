part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthRequiredParametersRequested extends AuthEvent {
  final String bank;
  AuthRequiredParametersRequested({
    required this.bank,
  });
}

class AuthStatusRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class ProviderChanged extends AuthEvent {
  final String provider;
  ProviderChanged({
    required this.provider,
  });
}

class AuthFieldChanged extends AuthEvent {
  final String fieldName;
  final String value;
  AuthFieldChanged({
    required this.fieldName,
    required this.value,
  });
}
