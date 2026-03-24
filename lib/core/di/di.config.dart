// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/academic_schedule/data/datasources/academic_schedule_remote_data_source.dart'
    as _i918;
import '../../features/academic_schedule/data/datasources/academic_schedule_remote_data_source_impl.dart'
    as _i849;
import '../../features/academic_schedule/data/repositories/academic_schedule_repo_impl.dart'
    as _i335;
import '../../features/academic_schedule/domain/repositories/academic_schedule_repo.dart'
    as _i189;
import '../../features/academic_schedule/domain/usecases/get_acadmic_schedule_use_case.dart'
    as _i877;
import '../../features/academic_schedule/presentation/cubit/academic_schedule_cubit.dart'
    as _i5;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i123;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/usecases/get_credentials_use_case.dart'
    as _i910;
import '../../features/auth/domain/usecases/get_user_site_info_use_case.dart'
    as _i142;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/my_courses/data/datasources/courses_local_data_source.dart'
    as _i374;
import '../../features/my_courses/data/datasources/courses_local_data_source_impl.dart'
    as _i853;
import '../../features/my_courses/data/datasources/courses_remote_data_source.dart'
    as _i144;
import '../../features/my_courses/data/datasources/courses_remote_data_source_impl.dart'
    as _i535;
import '../../features/my_courses/data/repositories/courses_repository_impl.dart'
    as _i855;
import '../../features/my_courses/domain/repositories/courses_repository.dart'
    as _i127;
import '../../features/my_courses/domain/usecases/get_course_content_use_case.dart'
    as _i369;
import '../../features/my_courses/domain/usecases/get_enrolled_courses_use_case.dart'
    as _i408;
import '../../features/my_courses/presentation/cubit/courses_cubit.dart'
    as _i355;
import '../local_storage/local_storage_client.dart' as _i401;
import '../local_storage/local_storage_client_impl.dart' as _i157;
import '../manager/app_manager.dart' as _i381;
import '../network/api_client.dart' as _i557;
import '../network/cis_api_client.dart' as _i858;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/session/user_session.dart' as _i120;
import 'local_storage_module.dart' as _i712;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localStorageModule = _$LocalStorageModule();
    final dioClient = _$DioClient();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => localStorageModule.secureStorage,
    );
    gh.lazySingleton<_i401.LocalStorageClient>(
      () => _i157.LocalStorageClientImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.singleton<_i120.UserSession>(
      () => _i120.UserSession(gh<_i401.LocalStorageClient>()),
    );
    gh.singleton<String>(
      () => dioClient.moodleBaseUrl,
      instanceName: 'moodle_baseUrl',
    );
    gh.singleton<String>(
      () => dioClient.servicesBaseUrl,
      instanceName: 'services_baseUrl',
    );
    gh.singleton<_i381.AppManager>(
      () => _i381.AppManager(
        gh<_i401.LocalStorageClient>(),
        gh<_i120.UserSession>(),
      ),
    );
    gh.singleton<_i745.AuthInterceptor>(
      () => _i745.AuthInterceptor(gh<_i120.UserSession>()),
    );
    gh.factory<_i374.CoursesLocalDataSource>(
      () => _i853.CoursesLocalDataSourceImpl(gh<_i401.LocalStorageClient>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioClient.provideDioClient(
        gh<_i745.AuthInterceptor>(),
        baseUrl: gh<String>(instanceName: 'moodle_baseUrl'),
      ),
    );
    gh.singleton<_i858.CisApiClient>(
      () => dioClient.provideCisApiClient(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'services_baseUrl'),
      ),
    );
    gh.singleton<_i557.ApiClient>(
      () => dioClient.provideApiClient(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'moodle_baseUrl'),
      ),
    );
    gh.factory<_i107.AuthRemoteDataSource>(
      () => _i123.AuthRemoteDataSourceImpl(
        gh<_i557.ApiClient>(),
        gh<_i858.CisApiClient>(),
      ),
    );
    gh.factory<_i918.AcademicScheduleRemoteDataSource>(
      () =>
          _i849.AcademicScheduleRemoteDataSourceImpl(gh<_i858.CisApiClient>()),
    );
    gh.factory<_i144.CoursesRemoteDataSource>(
      () => _i535.CoursesRemoteDataSourceImpl(
        gh<_i557.ApiClient>(),
        gh<_i120.UserSession>(),
      ),
    );
    gh.factory<_i189.AcademicScheduleRepo>(
      () => _i335.AcademicScheduleRepoImpl(
        gh<_i918.AcademicScheduleRemoteDataSource>(),
      ),
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(gh<_i107.AuthRemoteDataSource>()),
    );
    gh.factory<_i877.GetAcademicScheduleUseCase>(
      () => _i877.GetAcademicScheduleUseCase(gh<_i189.AcademicScheduleRepo>()),
    );
    gh.factory<_i910.GetCredentialsUseCase>(
      () => _i910.GetCredentialsUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i5.AcademicScheduleCubit>(
      () => _i5.AcademicScheduleCubit(gh<_i877.GetAcademicScheduleUseCase>()),
    );
    gh.factory<_i142.GetUserSiteInfoUseCase>(
      () => _i142.GetUserSiteInfoUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i127.CoursesRepository>(
      () => _i855.CoursesRepositoryImpl(
        gh<_i144.CoursesRemoteDataSource>(),
        gh<_i374.CoursesLocalDataSource>(),
      ),
    );
    gh.factory<_i408.GetEnrolledCoursesUseCase>(
      () => _i408.GetEnrolledCoursesUseCase(gh<_i127.CoursesRepository>()),
    );
    gh.factory<_i369.GetCourseContentUseCase>(
      () => _i369.GetCourseContentUseCase(gh<_i127.CoursesRepository>()),
    );
    gh.factory<_i355.CoursesCubit>(
      () => _i355.CoursesCubit(
        gh<_i408.GetEnrolledCoursesUseCase>(),
        gh<_i120.UserSession>(),
        gh<_i369.GetCourseContentUseCase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i37.LoginUseCase>(),
        gh<_i910.GetCredentialsUseCase>(),
        gh<_i142.GetUserSiteInfoUseCase>(),
        gh<_i401.LocalStorageClient>(),
        gh<_i120.UserSession>(),
      ),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i712.LocalStorageModule {}

class _$DioClient extends _i667.DioClient {}
