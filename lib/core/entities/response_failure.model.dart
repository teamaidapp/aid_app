/// It's a class that represents a failure response from the server
class ResponseFailureModel {
  /// It's a named constructor that receives two parameters and assigns them to
  ///  the class properties.
  ResponseFailureModel({
    required this.ok,
    required this.message,
  });

  /// It creates a default response failure model.
  ///
  /// Returns:
  ///   A ResponseFailureModel object with the default values.
  factory ResponseFailureModel.defaultFailureResponse() {
    return ResponseFailureModel(ok: false, message: 'Hubo un problema');
  }

  /// `copyWith` is a function that returns a new instance of the current class
  ///  with the values of the
  /// current class replaced with the values passed to the function
  ///
  /// Args:
  ///   ok (bool): This is a boolean value that indicates whether the request
  ///  was successful or not.
  ///   message (String): The error message.
  ///
  /// Returns:
  ///   A new instance of the ResponseFailureModel class.
  ResponseFailureModel copyWith({
    bool? ok,
    String? message,
  }) {
    return ResponseFailureModel(
      ok: ok ?? this.ok,
      message: message ?? this.message,
    );
  }

  /// It's a class property that represents the status of the response.
  final bool ok;

  /// It's a class property that represents the status of the response.
  final String message;
}
