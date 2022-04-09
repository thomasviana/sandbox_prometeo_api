part of 'auth_bloc.dart';

enum LinkStatus { linked, unlinked }

class AuthState {
  final LinkStatus status;
  final List<AuthField> authFields;
  final String provider;
  final String username;
  final String password;
  final String authKey;
  final bool isLoading;

  AuthState({
    this.status = LinkStatus.unlinked,
    this.authFields = const [],
    this.provider = '',
    this.username = '',
    this.password = '',
    this.authKey = '',
    this.isLoading = true,
  });

  AuthState copyWith({
    LinkStatus? status,
    List<AuthField>? authFields,
    String? provider,
    String? username,
    String? password,
    String? authKey,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      authFields: authFields ?? this.authFields,
      provider: provider ?? this.provider,
      username: username ?? this.username,
      password: password ?? this.password,
      authKey: authKey ?? this.authKey,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
