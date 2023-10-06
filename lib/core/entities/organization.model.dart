class OrganizationModel {
  const OrganizationModel({
    required this.id,
    required this.administratorName,
    required this.name,
  });

  factory OrganizationModel.fromMap(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'] as String,
      administratorName: map['administratorName'] as String? ?? '',
      name: map['name'] as String,
    );
  }

  OrganizationModel copyWith({
    String? id,
    String? administratorName,
    String? name,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      administratorName: administratorName ?? this.administratorName,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'administratorName': administratorName,
      'name': name,
    };
  }

  final String id;
  final String administratorName;
  final String name;
}
