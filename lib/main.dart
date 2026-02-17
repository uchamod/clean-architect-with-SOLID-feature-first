import 'package:clen_archetecture_bloc_app/core/routes/app_routes.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clen_archetecture_bloc_app/init_dependencies.main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "bloc app",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appDarkTheme,
      routerConfig: AppRoutes().router,
    );
  }
}
