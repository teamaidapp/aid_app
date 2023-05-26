import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/home/home.screen.dart';
import 'package:team_aid/features/login/login.screen.dart';
import 'package:team_aid/features/login/screens/create_account_coach.screen.dart';
import 'package:team_aid/features/login/screens/create_account_team.screen.dart';
import 'package:team_aid/features/login/screens/request_demo.screen.dart';

/// This class defines the routes for a GoRouter in a Flutter app, including
/// a home route and a login route.
class AppRoutes {
  /// The home route.
  static const String home = '/home';

  /// The login route.
  static const String login = '/login';

  /// The request demo route.
  static const String requestDemo = '/requestDemo';

  /// The create account coach route.
  static const String createAccountCoach = '/createAccountCoach';

  /// The create account team route.
  static const String createAccountTeam = '/createAccountTeam';
}

/// The routerProvider is a Provider that returns a GoRouter.
final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.requestDemo,
        builder: (context, state) => const RequestDemoScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccountCoach,
        builder: (context, state) => const CreateAccountCoachScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccountTeam,
        builder: (context, state) => const CreateAccountTeamScreen(),
      ),
    ],
  );
});
