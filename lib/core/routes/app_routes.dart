import 'package:clen_archetecture_bloc_app/core/routes/route_names.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/pages/login/login.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/pages/register/register.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: RouterNames.login,
        builder: (context, state) {
          return SingupPage();
        },
      ),
      GoRoute(
        path: "/register",
        name: RouterNames.register,
        builder: (context, state) {
          return SignUpPage();
        },
      ),
    ],
  );
}
