import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// The function opens a link in the default browser of the device.
///
/// Args:
///   link (String): A string representing the link to be opened.
///
/// Returns:
///   a Future<void> object.
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

/// The function checks if a given string follows the format of a valid date in the format "dd/mm/yyyy".
///
/// Args:
///   date (String): The `date` parameter is a string representing a date in the format "dd/mm/yyyy".
///
/// Returns:
///   a boolean value.
bool isValidDateFormat(String date) {
  final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegex.hasMatch(date)) {
    return false;
  }

  final parts = date.split('/');
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return false;
  }

  if (year > DateTime.now().year) {
    return false;
  }

  if (month < 1 || month > 12) {
    return false;
  }

  final daysInMonth = DateTime(year, month + 1, 0).day;
  if (day < 1 || day > daysInMonth) {
    return false;
  }

  return true;
}

/// The function checks if a given email string is valid according to a regular expression pattern.
///
/// Args:
///   email (String): The "email" parameter is a string that represents an email address.
///
/// Returns:
///   a boolean value indicating whether the given email is valid or not.
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  return emailRegex.hasMatch(email);
}

/// The function checks if a given phone number is valid by matching it against a regular expression.
///
/// Args:
///   phoneNumber (String): A string representing a phone number.
///
/// Returns:
///   a boolean value indicating whether the given phoneNumber is valid or not.
bool isValidPhoneNumber(String phoneNumber) {
  final phoneRegex = RegExp(r'^\d{10}$'); // Adjust the regex as per your desired format
  return phoneRegex.hasMatch(phoneNumber);
}
