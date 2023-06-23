/// A set of extension methods for the [String] class.
extension StringExtension on String {
  /// Capitalizes the first letter of this string.
  ///
  /// Returns a new string with the first letter capitalized.
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts this string to camel case.
  ///
  /// Returns a new string in camel case format.
  String toCamelCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join(' ');
  }

  /// Converts this string to pascal case.
  ///
  /// Returns a new string in pascal case format.
  String toPascalCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join();
  }

  /// Converts this string to snake case.
  ///
  /// Returns a new string in snake case format.
  String toSnakeCase() {
    return split(' ').map((String word) {
      return word.toLowerCase();
    }).join('_');
  }

  /// Capitalizes each word in this string.
  ///
  /// Returns a new string with each word capitalized.
  String capitalizeWord() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join(' ');
  }
}
