import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/home/home.screen.dart';
import 'package:team_aid/features/login/login.screen.dart';

class AppRoutes {
  static const String home = '/home';

  static const String login = '/login';
}

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
