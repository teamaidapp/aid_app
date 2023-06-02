/// A class representing a team in the system.
class TeamModel {
  /// Creates a new team with the given properties.
  const TeamModel({
    required this.teamName,
    required this.sport,
    required this.ageGroup,
    required this.gender,
    required this.organization,
    required this.country,
    required this.zipCode,
    required this.state,
    required this.level,
  });

  /// Creates a new team from a map of key-value pairs.
  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      teamName: map['teamName'] as String,
      sport: map['sport'] as String,
      ageGroup: map['ageGroup'] as String,
      gender: map['gender'] as String,
      organization: map['organization'] as String,
      country: map['country'] as String,
      zipCode: map['zipCode'] as String,
      state: map['state'] as String,
      level: map['level'] as String,
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
  }) {
    return TeamModel(
      teamName: teamName ?? this.teamName,
      sport: sport ?? this.sport,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      organization: organization ?? this.organization,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      state: state ?? this.state,
      level: level ?? this.level,
    );
  }

  /// Converts this team to a map of key-value pairs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teamName': teamName,
      'sport': sport,
      'ageGroup': ageGroup,
      'gender': gender,
      'organization': organization,
      'country': country,
      'zipCode': zipCode,
      'state': state,
      'level': level,
    };
  }

  @override
  String toString() {
    return 'TeamModel(teamName: $teamName, sport: $sport, ageGroup: $ageGroup, gender: $gender, organization: $organization, country: $country, zipCode: $zipCode, state: $state, level: $level)';
  }

  /// The name of the team.
  final String teamName;

  /// The sport the team plays.
  final String sport;

  /// The age group the team belongs to.
  final String ageGroup;

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

  /// The level of the team.
  final String level;
}
