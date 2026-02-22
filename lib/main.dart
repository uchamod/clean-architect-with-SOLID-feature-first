import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/core/wrapper_pages/splash_screen.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/pages/login/login.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/home.dart';
import 'package:clen_archetecture_bloc_app/init_dependencies.main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthuserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bloc app",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appDarkTheme,
      home: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          print("current state $state");
          if (state is AppUserLoading) {
            return const SplashScreen();
          }
          if (state is AppUserLoggedIn) {
            return const HomePage();
          }
          return const SingInPage();
        },
      ),
    );
  }
}
