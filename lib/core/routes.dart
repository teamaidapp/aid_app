import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/home/home.screen.dart';
import 'package:team_aid/features/login/login.screen.dart';

/// This class defines the routes for a GoRouter in a Flutter app, including
/// a home route and a login route.
class AppRoutes {
  /// The home route.
  static const String home = '/home';

  /// The login route.
  static const String login = '/login';
}

/// The routerProvider is a Provider that returns a GoRouter.
final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
});
