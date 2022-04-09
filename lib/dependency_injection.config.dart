// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/auth/domain.dart' as _i3;
import 'core/auth/src/application/auth_bloc/auth_bloc.dart' as _i5;
import 'core/auth/src/infrastructure/auth_repository_impl.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl());
  gh.factory<_i5.AuthBloc>(() => _i5.AuthBloc(get<_i3.AuthRepository>()));
  return get;
}
