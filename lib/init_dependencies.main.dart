part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  Hive.defaultDirectory = (await getApplicationCacheDirectory()).path;
  //core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );
}

//auth service locator
void _initAuth() {
  serviceLocator.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
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

  serviceLocator.registerFactory<LocalRemoteDataSource>(
    () => LocalRemoteDataSourceImpl(box: serviceLocator()),
  );
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      remoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
      localRemoteDataSource: serviceLocator(),
    ),
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
