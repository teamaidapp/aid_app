/// A class representing a request for a demo in the system.
class RequestDemoModel {
  /// Creates a new request for a demo with the given properties.
  const RequestDemoModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.leagueOrClub,
  });

  /// Creates a copy of this request for a demo with the given properties replaced.
  RequestDemoModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? leagueOrClub,
  }) {
    return RequestDemoModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      leagueOrClub: leagueOrClub ?? this.leagueOrClub,
    );
  }

  /// Converts this request for a demo to a map of key-value pairs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'LeagueOrClub': leagueOrClub,
    };
  }

  @override
  String toString() {
    return 'RequestDemoModel(name: $name, email: $email, phone: $phone, LeagueOrClub: $leagueOrClub)';
  }

  /// The name of the person requesting the demo.
  final String name;

  /// The email address of the person requesting the demo.
  final String email;

  /// The phone number of the person requesting the demo.
  final String phone;

  /// The name of the league or club the person belongs to.
  final String leagueOrClub;
}
