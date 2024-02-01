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
