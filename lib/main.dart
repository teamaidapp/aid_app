import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/routes.dart';

Future<void> main() async {
  await dotenv.load(
    fileName: kReleaseMode ? '.env' : '.env.staging',
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

/// `final httpProvider` is a Riverpod provider that provides an instance of `http.Client` to its
/// dependents. The `Provider` constructor takes a callback function that returns the value that the
/// provider provides. In this case, the callback function takes a `ref` argument, which is a
/// `ProviderReference` object that can be used to read other providers or create new ones. The callback
/// function simply returns a new instance of `http.Client`, which is then provided to any dependent
/// widgets that use `httpProvider` as a dependency.
final httpProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// `final sharedPrefs` is a `FutureProvider` that provides a `SharedPreferences` instance to its
/// dependents. The `FutureProvider` constructor takes a callback function that returns a `Future` of
/// the value that the provider provides. In this case, the callback function is an async function that
/// returns the result of calling `SharedPreferences.getInstance()`, which is a
/// `Future<SharedPreferences>`. The `FutureProvider` will asynchronously create and provide the
/// `SharedPreferences` instance to any dependent widgets that use `sharedPrefs` as a dependency.
final sharedPrefs = FutureProvider<SharedPreferences>(
  (_) async => SharedPreferences.getInstance(),
);

/// The MainApp class is a ConsumerWidget that builds a MaterialApp with a
/// router based on the current
/// device's orientation and type.
class MainApp extends ConsumerWidget {
  /// Constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
