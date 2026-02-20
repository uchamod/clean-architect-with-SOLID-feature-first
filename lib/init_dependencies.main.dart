import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:clen_archetecture_bloc_app/core/secrets/app_secrets.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_login_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_register_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  //core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

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
