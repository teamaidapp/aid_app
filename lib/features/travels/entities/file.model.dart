class FileT {
  final String id;
  final String description;
  final String fileName;
  final String fileKey;
  final String createdAt;
  final String updateAt;
  FileT({
    required this.id,
    required this.description,
    required this.fileName,
    required this.fileKey,
    required this.createdAt,
    required this.updateAt,
  });

  FileT copyWith({
    String? id,
    String? description,
    String? fileName,
    String? fileKey,
    String? createdAt,
    String? updateAt,
  }) {
    return FileT(
      id: id ?? this.id,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      fileKey: fileKey ?? this.fileKey,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'fileName': fileName,
      'fileKey': fileKey,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  factory FileT.fromMap(Map<String, dynamic> map) {
    return FileT(
      id: map['id'] as String? ?? '',
      description: map['description'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      fileKey: map['fileKey'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
      updateAt: map['updateAt'] as String? ?? '',
    );
  }
  @override
  String toString() {
    return 'File(id: $id, description: $description, fileName: $fileName, fileKey: $fileKey, createdAt: $createdAt, updateAt: $updateAt)';
  }
}
