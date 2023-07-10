/// A class representing a user file.
class UserFiles {
  /// Creates a new instance of [UserFiles].
  ///
  /// The [id], [fileName], [fileKey], [createdAt], and [updateAt] parameters are required and represent the properties of the user file.
  ///
  /// The [description] parameter is optional and represents the description of the user file.
  const UserFiles({
    required this.id,
    required this.fileName,
    required this.fileKey,
    required this.createdAt,
    required this.updateAt,
    this.description,
  });

  /// Creates a new instance of [UserFiles] from a map.
  ///
  /// The [map] parameter is required and represents the map to convert to a [UserFiles] instance.
  factory UserFiles.fromMap(Map<String, dynamic> map) {
    return UserFiles(
      id: map['id'] as String,
      description: map['description'] as String?,
      fileName: map['fileName'] as String,
      fileKey: map['fileKey'] as String,
      createdAt: map['createdAt'] as String,
      updateAt: map['updateAt'] as String,
    );
  }

  /// Creates a copy of this [UserFiles] instance with the specified properties replaced.
  ///
  /// The [id], [fileName], [fileKey], [createdAt], and [updateAt] parameters are optional and represent the properties to replace.
  ///
  /// Returns a new [UserFiles] instance with the specified properties replaced.
  UserFiles copyWith({
    String? id,
    String? description,
    String? fileName,
    String? fileKey,
    String? createdAt,
    String? updateAt,
  }) {
    return UserFiles(
      id: id ?? this.id,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      fileKey: fileKey ?? this.fileKey,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Converts this [UserFiles] instance to a map.
  ///
  /// Returns a map representation of this [UserFiles] instance.
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

  /// Returns a string representation of this [UserFiles] instance.
  @override
  String toString() {
    return 'UserFiles(id: $id, description: $description, fileName: $fileName, fileKey: $fileKey, createdAt: $createdAt, updateAt: $updateAt)';
  }

  /// The ID of the user file.
  final String id;

  /// The description of the user file.
  final String? description;

  /// The name of the user file.
  final String fileName;

  /// The key of the user file.
  final String fileKey;

  /// The creation date of the user file.
  final String createdAt;

  /// The update date of the user file.
  final String updateAt;
}
