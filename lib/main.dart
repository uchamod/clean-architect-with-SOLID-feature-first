import 'package:clen_archetecture_bloc_app/core/routes/app_routes.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
