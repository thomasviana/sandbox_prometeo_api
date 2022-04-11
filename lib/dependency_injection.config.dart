// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/auth/domain.dart' as _i3;
import 'core/auth/src/application/auth_bloc/auth_bloc.dart' as _i10;
import 'core/auth/src/infrastructure/auth_repository_impl.dart' as _i4;
import 'core/bank_products/domain.dart' as _i5;
import 'core/bank_products/src/application/bank_products_bloc/bank_products_bloc.dart'
    as _i11;
import 'core/bank_products/src/infrastructure/bank_products_repository_impl.dart'
    as _i6;
import 'core/movements/domain.dart' as _i7;
import 'core/movements/src/application/movements_bloc/movements_bloc.dart'
    as _i9;
import 'core/movements/src/infrastructure/movement_repository_impl.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl());
  gh.lazySingleton<_i5.BankProductsRepository>(
      () => _i6.BankProductsRepositoryImpl());
  gh.lazySingleton<_i7.MovementRepository>(() => _i8.MovementRepositoryImpl());
  gh.factory<_i9.MovementsBloc>(
      () => _i9.MovementsBloc(get<_i7.MovementRepository>()));
  gh.factory<_i10.AuthBloc>(() => _i10.AuthBloc(get<_i3.AuthRepository>()));
  gh.factory<_i11.BankProductsBloc>(
      () => _i11.BankProductsBloc(get<_i5.BankProductsRepository>()));
  return get;
}
