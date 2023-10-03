import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/features/calendar/calendar.screen.dart';
import 'package:team_aid/features/home/home.screen.dart';
import 'package:team_aid/features/home/screens/add_coach.screen.dart';
import 'package:team_aid/features/home/screens/add_player.screen.dart';
import 'package:team_aid/features/household/household.screen.dart';
import 'package:team_aid/features/login/login.screen.dart';
import 'package:team_aid/features/login/screens/create_account_coach.screen.dart';
import 'package:team_aid/features/login/screens/create_account_team.screen.dart';
import 'package:team_aid/features/login/screens/create_account_team_player.screen.dart';
import 'package:team_aid/features/login/screens/create_account_team_player_parents.screen.dart';
import 'package:team_aid/features/login/screens/request_demo.screen.dart';
import 'package:team_aid/features/myAccount/myAccount.screen.dart';
import 'package:team_aid/features/myAccount/screens/address.screen.dart';
import 'package:team_aid/features/myAccount/screens/biography.screen.dart';
import 'package:team_aid/features/myAccount/screens/phone.screen.dart';
import 'package:team_aid/features/teams/screens/contacts-list.screen.dart';
import 'package:team_aid/features/teams/screens/join_team.screen.dart';
import 'package:team_aid/features/teams/teams.screen.dart';
import 'package:team_aid/features/travels/screens/files.screen.dart';
import 'package:team_aid/features/travels/travels.screen.dart';

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
  static const String createAccountTeamForCoach = '/createAccountTeam';

  /// The create account team player parents route.
  static const String createAccountParents = '/createAccountParents';

  /// The create account team player route.
  static const String createAccountTeamPlayer = '/createAccountTeamPlayer';

  /// The add player route.
  static const String addPlayer = '/home/addPlayer';

  /// The team route.
  static const String teams = '/home/team';

  /// Contact list route.
  static const String contactList = '/home/team/contactList';

  /// Calendar route.
  static const String calendar = '/home/calendar';

  /// Travel route.
  static const String travel = '/home/travel';

  /// Account route.
  static const String account = '/account';

  /// Biography profile route.
  static const String biography = '/account/biography';

  /// Phone profile route.
  static const String phoneProfile = '/account/phoneProfile';

  /// Address profile route
  static const String addressProfile = '/account/address';

  /// Household route
  static const String household = '/household';

  /// Add Coach route
  static const String addCoach = '/home/team/addCoach';

  /// Join Team route
  static const String joinTeam = '/home/joinTeam';

  /// Files route
  static const String files = '/home/files';
}

/// The routerProvider is a Provider that returns a GoRouter.
final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: AppRoutes.joinTeam,
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
        name: AppRoutes.createAccountCoach,
        builder: (context, state) => CreateAccountCoachScreen(
          isAdmin: state.queryParameters['isAdmin'] == 'true',
        ),
      ),
      GoRoute(
        path: AppRoutes.createAccountTeamForCoach,
        builder: (context, state) => const CreateAccountTeamScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccountParents,
        builder: (context, state) => const CreateAccountParentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addPlayer,
        builder: (context, state) => const AddPlayerScreen(),
      ),
      GoRoute(
        path: AppRoutes.teams,
        builder: (context, state) => const TeamsScreen(),
      ),
      GoRoute(
        path: AppRoutes.contactList,
        name: AppRoutes.contactList,
        builder: (context, state) => ContactsListScreen(
          teamId: state.queryParameters['id']!,
          teamName: state.queryParameters['name']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: AppRoutes.travel,
        builder: (context, state) => const TravelsScreen(),
      ),
      GoRoute(
        path: AppRoutes.account,
        builder: (context, state) => const MyAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.biography,
        builder: (context, state) => const BiographyScreen(),
      ),
      GoRoute(
        path: AppRoutes.phoneProfile,
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: AppRoutes.addressProfile,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccountTeamPlayer,
        name: AppRoutes.createAccountTeamPlayer,
        builder: (context, state) => CreateAccountTeamPlayerScreen(
          isCreatingSon: state.queryParameters['isCreatingSon'] == 'true',
        ),
      ),
      GoRoute(
        path: AppRoutes.household,
        builder: (context, state) => const HouseholdScreen(),
      ),
      GoRoute(
        path: AppRoutes.addCoach,
        builder: (context, state) => const AddCoachScreen(),
      ),
      GoRoute(
        path: AppRoutes.joinTeam,
        builder: (context, state) => const JoinTeamScreen(),
      ),
      GoRoute(
        path: AppRoutes.files,
        name: AppRoutes.files,
        builder: (context, state) => FilesScreen(
          isInTravel: state.queryParameters['isInTravel'] == ' true',
        ),
      ),
    ],
  );
});
