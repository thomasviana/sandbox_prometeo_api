// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/accounts/domain.dart' as _i5;
import 'core/accounts/src/application/accounts_bloc/bank_accounts_bloc.dart'
    as _i7;
import 'core/accounts/src/infrastructure/bank_account_repository_impl.dart'
    as _i6;
import 'core/auth/domain.dart' as _i3;
import 'core/auth/src/application/auth_bloc/auth_bloc.dart' as _i11;
import 'core/auth/src/infrastructure/auth_repository_impl.dart' as _i4;
import 'core/movements/domain.dart' as _i8;
import 'core/movements/src/application/movements_bloc/movements_bloc.dart'
    as _i10;
import 'core/movements/src/infrastructure/movement_repository_impl.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl());
  gh.lazySingleton<_i5.BankAccountRepository>(
      () => _i6.BankAccountRepositoryImpl());
  gh.factory<_i7.BankAccountsBloc>(
      () => _i7.BankAccountsBloc(get<_i5.BankAccountRepository>()));
  gh.lazySingleton<_i8.MovementRepository>(() => _i9.MovementRepositoryImpl());
  gh.factory<_i10.MovementsBloc>(
      () => _i10.MovementsBloc(get<_i8.MovementRepository>()));
  gh.factory<_i11.AuthBloc>(() => _i11.AuthBloc(get<_i3.AuthRepository>()));
  return get;
}
