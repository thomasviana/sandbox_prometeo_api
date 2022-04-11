import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/core/auth/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(
    this.authRepository,
  ) : super(AuthState()) {
    on<AuthRequiredParametersRequested>(_onAuthRequiredParametersRequested);
    on<AuthStatusRequested>(_onAuthStatusRequested);
    on<ProviderChanged>(_onProviderChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthRequiredParametersRequested(
    AuthRequiredParametersRequested event,
    Emitter<AuthState> emit,
  ) async {
    final requiredParameters =
        await authRepository.getRequiredParameters('test');
    emit(state.copyWith(
      authFields: requiredParameters.authFields,
      provider: requiredParameters.name,
      isLoading: false,
    ));
  }

  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    await emit.onEach<AuthResponse>(
        authRepository.checkAuthStatus(Credentials(
          provider: 'test',
          username: state.username,
          password: state.password,
        )), onData: (authResponse) {
      authResponse.status == 'logged_in'
          ? emit(state.copyWith(
              status: LinkStatus.linked,
              authKey: authResponse.authKey,
            ))
          : emit(state.copyWith(status: LinkStatus.unlinked));
    });
  }

  Future<void> _onProviderChanged(
    ProviderChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(provider: event.provider));
  }

  Future<void> _onUsernameChanged(
    UsernameChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(username: event.username));
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    unawaited(authRepository.logOut());
    emit(state.copyWith(status: LinkStatus.unlinked));
  }
}
