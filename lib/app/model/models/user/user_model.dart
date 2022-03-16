import 'dart:convert';

class UserModel {
  final String uuid;
  final String idAuth;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool doing;
  final DateTime createdAt;
  UserModel({
    required this.uuid,
    required this.idAuth,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.doing,
    required this.createdAt,
  });

  UserModel copyWith({
    String? uuid,
    String? idAuth,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? doing,
    DateTime? createdAt,
  }) {
    return UserModel(
      uuid: uuid ?? this.uuid,
      idAuth: idAuth ?? this.idAuth,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      doing: doing ?? this.doing,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'idAuth': idAuth,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'doing': doing,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] ?? '',
      idAuth: map['idAuth'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      doing: map['doing'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt']?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uuid: $uuid, idAuth: $idAuth, email: $email, displayName: $displayName, photoUrl: $photoUrl, doing: $doing, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uuid == uuid &&
        other.idAuth == idAuth &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.doing == doing &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        idAuth.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        doing.hashCode ^
        createdAt.hashCode;
  }
}
