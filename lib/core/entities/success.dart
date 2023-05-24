/// The Failure class is an exception class in Dart that contains information about a failure, including
/// a message, code, exception, and stack trace.
class Success implements Exception {
  /// Constructor
  Success({
    required this.ok,
    required this.message,
    this.code,
  });

  /// The message of the failure.
  final String message;

  /// The code of the failure.
  final int? code;

  /// If the operation was successful
  final bool ok;

  @override
  String toString() {
    return 'Failure(message: $message, code: $code';
  }
}
