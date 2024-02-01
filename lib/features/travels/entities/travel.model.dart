class TravelModel {
  const TravelModel({
    required this.name,
    required this.transportation,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.locationDescription,
    required this.files,
    required this.hotel,
    required this.hotelGoogle,
    required this.arrivalDate,
    required this.departureDate,
  });

  TravelModel copyWith({
    String? name,
    String? transportation,
    String? startDate,
    String? endDate,
    String? location,
    String? locationDescription,
    List<TravelFile>? files,
    String? hotel,
    String? hotelGoogle,
    String? arrivalDate,
    String? departureDate,
  }) {
    return TravelModel(
      name: name ?? this.name,
      transportation: transportation ?? this.transportation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      files: files ?? this.files,
      hotel: hotel ?? this.hotel,
      hotelGoogle: hotelGoogle ?? this.hotelGoogle,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      departureDate: departureDate ?? this.departureDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'transportation': transportation,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'locationDescription': locationDescription,
      'files': files.map((x) => x.toMap()).toList(),
      'hotel': hotel,
      'hotelGoogle': hotelGoogle,
      'arrivalDate': arrivalDate,
      'departureDate': departureDate,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      name: map['name'] as String,
      transportation: map['transportation'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      location: map['location'] as String,
      locationDescription: map['locationDescription'] as String,
      files: List<TravelFile>.from(
        (map['files'] as List<int>).map<TravelFile>(
          (x) => TravelFile.fromMap(x as Map<String, dynamic>),
        ),
      ),
      hotel: map['hotel'] as String,
      hotelGoogle: map['hotelGoogle'] as String,
      arrivalDate: map['arrivalDate'] as String,
      departureDate: map['departureDate'] as String,
    );
  }

  @override
  String toString() {
    return 'TravelModel(name: $name, transportation: $transportation, startDate: $startDate, endDate: $endDate, location: $location, locationDescription: $locationDescription, files: $files, hotel: $hotel, hotelGoogle: $hotelGoogle)';
  }

  final String name;
  final String transportation;
  final String startDate;
  final String endDate;
  final String location;
  final String locationDescription;
  final List<TravelFile> files;
  final String hotel;
  final String hotelGoogle;
  final String arrivalDate;
  final String departureDate;
}

class TravelFile {
  final String fileId;
  TravelFile({
    required this.fileId,
  });

  TravelFile copyWith({
    String? fileId,
  }) {
    return TravelFile(
      fileId: fileId ?? this.fileId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileId': fileId,
    };
  }

  factory TravelFile.fromMap(Map<String, dynamic> map) {
    return TravelFile(
      fileId: map['fileId'] as String,
    );
  }
}
