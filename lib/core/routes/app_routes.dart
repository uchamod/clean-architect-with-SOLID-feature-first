import 'package:clen_archetecture_bloc_app/core/routes/route_names.dart';
import 'package:clen_archetecture_bloc_app/core/wrapper_pages/wrapper_page.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/home.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/pages/login/login.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/pages/register/register.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: RouterNames.wrapper,
        builder: (context, state) {
          return WrapperPage();
        },
      ),
      GoRoute(
        path: "/register",
        name: RouterNames.register,
        builder: (context, state) {
          return SignUpPage();
        },
      ),
      GoRoute(
        path: "/home",
        name: RouterNames.home,
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: "/login",
        name: RouterNames.login,
        builder: (context, state) {
          return SingInPage();
        },
      ),
    ],
  );
}
