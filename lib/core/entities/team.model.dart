/// A class representing a team in the system.
class TeamModel {
  /// Creates a new team with the given properties.
  const TeamModel({
    required this.teamName,
    required this.sport,
    required this.gender,
    required this.organization,
    required this.country,
    required this.zipCode,
    required this.state,
    required this.level,
    required this.id,
    required this.city,
  });

  /// Creates a new team from a map of key-value pairs.
  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      teamName: map['teamName'] as String,
      sport: map['sport'] as String,
      gender: map['gender'] as String,
      level: map['level'] as String,
      id: map['id'] as String,
      organization: map['organization'] as String? ?? '',
      country: map['country'] as String? ?? '',
      zipCode: map['zipCode'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
    );
  }

  /// Creates a copy of this team with the given properties replaced.
  TeamModel copyWith({
    String? teamName,
    String? sport,
    String? ageGroup,
    String? gender,
    String? organization,
    String? country,
    String? zipCode,
    String? state,
    String? level,
    String? id,
    String? city,
  }) {
    return TeamModel(
      teamName: teamName ?? this.teamName,
      sport: sport ?? this.sport,
      gender: gender ?? this.gender,
      organization: organization ?? this.organization,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      state: state ?? this.state,
      level: level ?? this.level,
      id: id ?? this.id,
      city: city ?? this.city,
    );
  }

  /// Converts this team to a map of key-value pairs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teamName': teamName,
      'sport': sport,
      'gender': gender,
      'level': level,
      // 'organization': organization,
      // 'country': country,
      // 'zipCode': zipCode,
      // 'state': state,
      // 'city': city,
    };
  }

  @override
  String toString() {
    return 'TeamModel(teamName: $teamName, sport: $sport, gender: $gender, organization: $organization, country: $country, zipCode: $zipCode, state: $state, level: $level, city: $city)';
  }

  /// The name of the team.
  final String teamName;

  /// The sport the team plays.
  final String sport;

  /// The gender of the team.
  final String gender;

  /// The organization the team belongs to.
  final String organization;

  /// The country the team is located in.
  final String country;

  /// The zip code of the team's location.
  final String zipCode;

  /// The state the team is located in.
  final String state;

  /// The city the team is located in.
  final String? city;

  /// The level of the team.
  final String level;

  /// The id of the team.
  final String id;
}
