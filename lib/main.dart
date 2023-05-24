import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';

void main() {
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
        );
      },
    );
  }
}
