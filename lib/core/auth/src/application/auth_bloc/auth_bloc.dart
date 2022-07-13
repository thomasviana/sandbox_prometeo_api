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
    on<AuthFieldChanged>(_onAuthFieldChanged);
    on<LogoutRequested>(_onLogoutRequested);
  }
  List<AuthField> _authFields = [];

  Future<void> _onAuthRequiredParametersRequested(
    AuthRequiredParametersRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.getAuthFields('test').then(
          (value) =>
              value..fold(() {}, (authFields) => _authFields = authFields),
        );
    emit(state.copyWith(
      authFields: _authFields,
      provider: 'test',
      isLoading: false,
    ));
  }

  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    print(_authFields.map((authField) => authField.value).toList());
    await emit.onEach<AuthResponse>(
        authRepository.checkAuthStatus(
          _authFields.map((authField) => authField.value).toList(),
        ), onData: (authResponse) {
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

  Future<void> _onAuthFieldChanged(
    AuthFieldChanged event,
    Emitter<AuthState> emit,
  ) async {
    _authFields = _authFields
        .map((field) => field.name == event.fieldName
            ? field.copyWith(value: event.value)
            : field)
        .toList();
    emit(state.copyWith(authFields: _authFields));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    unawaited(authRepository.logOut());
    emit(state.copyWith(status: LinkStatus.unlinked));
  }
}
