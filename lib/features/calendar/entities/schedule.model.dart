// ignore_for_file: public_member_api_docs

class ScheduleModel {
  const ScheduleModel({
    required this.eventName,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.eventDescription,
    required this.guest,
    required this.periodicity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'eventDescription': eventDescription,
      'guest': guest.map((x) => x.toMap()).toList(),
      'periodicity': periodicity,
    };
  }

  final String eventName;
  final String startDate;
  final String endDate;
  final String location;
  final String eventDescription;
  final List<Guest> guest;
  final String periodicity;
}

class Guest {
  const Guest({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  final String userId;
}
