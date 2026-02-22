import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:clen_archetecture_bloc_app/core/secrets/app_secrets.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_login_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_register_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/data_source/remote_data_source.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/repository/blog_repository_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/usecase/blog_fetch.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/usecase/blog_upload_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  //core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

//auth service locator
void _initAuth() {
  serviceLocator.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserRegisterUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserLoginUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetCurrentUserUsecase(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      getCurrentUserUsecase: serviceLocator(),
      userRegisterUsecase: serviceLocator(),
      userLoginUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

//blog service locator
void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => BlogFetchUseCase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => BlogUploadUsecase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      blogUploadUsecase: serviceLocator(),
      blogFetchUseCase: serviceLocator(),
    ),
  );
}
