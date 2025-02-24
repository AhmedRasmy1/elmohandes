// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources_impl/data_sources_impl.dart'
    as _i1072;
import '../../features/auth/data/repositores/auth_repo_impl.dart' as _i198;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/presentation/viewmodel/cubit/login_cubit.dart'
    as _i641;
import '../api/api_manager/api_manager.dart' as _i680;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.providerDio());
    gh.factory<_i680.ApiService>(() => _i680.ApiService(gh<_i361.Dio>()));
    gh.factory<_i1072.LoginDataSourceImpl>(
        () => _i1072.LoginDataSourceImpl(gh<_i680.ApiService>()));
    gh.factory<_i723.LoginRepo>(
        () => _i198.LoginRepoImpl(gh<_i1072.LoginDataSourceImpl>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(gh<_i723.LoginRepo>()));
    gh.factory<_i641.LoginCubit>(
        () => _i641.LoginCubit(gh<_i1038.LoginUseCase>()));
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
