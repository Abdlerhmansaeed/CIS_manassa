// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i123;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/usecases/get_credentials_use_case.dart'
    as _i910;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../network/api_client.dart' as _i557;
import '../network/dio_client.dart' as _i667;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioClient = _$DioClient();
    gh.lazySingleton<_i361.Dio>(() => dioClient.provideDioClient());
    gh.singleton<_i557.ApiClient>(
      () => dioClient.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i107.AuthRemoteDataSource>(
      () => _i123.AuthRemoteDataSourceImpl(
        gh<_i557.ApiClient>(),
        gh<_i361.Dio>(),
      ),
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(gh<_i107.AuthRemoteDataSource>()),
    );
    gh.factory<_i910.GetCredentialsUseCase>(
      () => _i910.GetCredentialsUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i37.LoginUseCase>(),
        gh<_i910.GetCredentialsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioClient extends _i667.DioClient {}
