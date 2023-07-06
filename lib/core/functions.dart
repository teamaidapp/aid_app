import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Open a link
Future<void> openLink(String link) async {
  final parsedLink = Uri.parse(link);
  if (await canLaunchUrl(parsedLink)) {
    await launchUrl(parsedLink, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('No se pudo abrir el link.');
  }
}

/// The function returns a TextEditingController that is initialized with the value stored in
/// SharedPreferences using the provided sharedPreferencesKey.
///
/// Args:
///   sharedPreferencesKey (String): The `sharedPreferencesKey` parameter is a required parameter of
/// type `String`. It represents the key used to retrieve the value from the shared preferences.
///
/// Returns:
///   a `TextEditingController` object.
TextEditingController useSharedPrefsTextEditingController({
  required String sharedPreferencesKey,
}) {
  final controller = useTextEditingController();

  useEffect(
    () {
      SharedPreferences.getInstance().then((prefs) {
        final value = prefs.getString(sharedPreferencesKey) ?? '';
        controller.text = value;
      });
      return () {};
    },
    [controller],
  );

  return controller;
}
