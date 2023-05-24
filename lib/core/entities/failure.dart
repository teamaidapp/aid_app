/// The Failure class is an exception class in Dart that contains information about a failure, including
/// a message, code, exception, and stack trace.
class Failure implements Exception {
  /// Constructor
  Failure({
    required this.message,
    this.ok = false,
    this.stackTrace,
    this.code,
    this.exception,
  });

  /// If the operation was not successful
  final bool ok;

  /// The message of the failure.
  final String message;

  /// The code of the failure.
  final int? code;

  /// The exception of the failure.
  final Exception? exception;

  /// The stack trace of the failure.
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure(message: $message, code: $code, exception: $exception, stackTrace: $stackTrace)';
  }
}
