import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';

/// The GlobalFunctions class has a method to save user session data to SharedPreferences.
class GlobalFunctions {
  /// The function saves user session data to shared preferences.
  ///
  /// Args:
  ///   user (UserModel): A required UserModel object that contains information about the user, such as
  /// their first name, last name, email, phone number, address, and role.
  ///   token (String): The token is a string that represents an authentication token that is used to
  /// authenticate the user's session. It is usually generated by the server and sent to the client upon
  /// successful login or authentication. The token is then stored on the client-side and sent with each
  /// subsequent request to the server to authenticate the user
  Future<void> saveUserSession({
    required UserModel user,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: TAConstants.accessToken, value: token);
    await prefs.setString(TAConstants.firstName, user.firstName);
    await prefs.setString(TAConstants.lastName, user.lastName);
    await prefs.setString(TAConstants.email, user.email);
    await prefs.setString(TAConstants.phoneNumber, user.phoneNumber);
    await prefs.setString(TAConstants.role, user.role.name);
    await prefs.setString(TAConstants.sport, user.sportId);
    await prefs.setString(TAConstants.biography, user.biography);
    await prefs.setString(TAConstants.avatar, user.avatar ?? '');
    await prefs.setBool(TAConstants.isEmailVisible, user.isEmailVisible ?? false);
    await prefs.setBool(TAConstants.isPhoneVisible, user.isPhoneVisible ?? false);
    await prefs.setBool(TAConstants.isFatherVisible, user.isFatherVisible ?? false);
    await prefs.setBool(TAConstants.isAvatarVisible, user.isAvatarVisible ?? false);
    await prefs.setBool(TAConstants.isBiographyVisible, user.isBiographyVisible ?? false);
  }

  /// The function generates a list of HourModel objects representing hours and minutes in both AM and PM
  /// formats.
  ///
  /// Returns:
  ///   The function `generateHourModels()` returns a list of `HourModel` objects.
  static List<HourModel> generateHourModels(int startHour) {
    if (startHour < 0 || startHour > 23) {
      throw ArgumentError('The startHour should be between 0 and 23 (inclusive).');
    }

    final hourModels = <HourModel>[];

    for (var i = startHour; i <= startHour + 11; i++) {
      final hour = i % 24;
      hourModels
        ..add(HourModel(hour: hour.toString().padLeft(2, '0'), description: '$hour:00', minute: '00'))
        ..add(HourModel(hour: hour.toString().padLeft(2, '0'), description: '$hour:30', minute: '30'));
    }

    return hourModels;
  }

  /// This function returns a list of all the days in a given month and year.
  ///
  /// Args:
  ///   year (int): The year for which we want to get the days in a month. It is a required parameter and
  /// must be provided while calling the function.
  ///   month (int): The month parameter is an integer value representing the month of the year, where
  /// January is 1 and December is 12.
  ///
  /// Returns:
  ///   a list of DateTime objects representing all the days in a given month and year.
  static List<DateTime> getDaysInMonth({
    required int year,
    required int month,
  }) {
    final daysInMonth = <DateTime>[];

    final daysCount = DateTime(year, month + 1, 0).day;

    for (var day = 1; day <= daysCount; day++) {
      daysInMonth.add(DateTime(year, month, day));
    }

    return daysInMonth;
  }

  /// This function generates a list of months starting from the current month and year up to December of the given year.
  ///
  /// Args:
  ///   year (int): The year up to which we want to generate the list of months. It is a required parameter and
  /// must be provided while calling the function.
  ///
  /// Returns:
  ///   a list of strings representing the months from the current month and year up to December of the given year.
  ///   The month numbers are represented as strings.
  ///
  /// Throws:
  ///   ArgumentError: If the year is less than the current year.
  static List<String> aheadMonths(int year) {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;
    final months = <String>[];

    if (year == currentYear) {
      for (var month = currentMonth; month <= 12; month++) {
        months.add(month.toString());
      }
    } else if (year > currentYear) {
      for (var month = 1; month <= 12; month++) {
        months.add(month.toString());
      }
    } else {
      throw ArgumentError('The year should be greater than or equal to the current year.');
    }

    return months;
  }
}
