import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/created_at.dart';

class UserEntity {
  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final CreatedAt? createdAt;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.createdAt,
  });

  // Méthode pour convertir un JSON en objet User
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] != null ? json['id'] as String : null,
      name: json['name'] != null ? json['name'] as String : '',
      email: json['email'] != null ? json['email'] as String : '',
      phoneNumber:
          json['phoneNumber'] != null ? json['phoneNumber'] as String : '',
      password: json['password'] != null ? json['password'] as String : '',
      createdAt: json['createdAt'] != null
        ? CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>)
        : CreatedAt.defaultValue()
    );
  }

  // Méthode pour convertir un objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'createdAt': createdAt!.toJson(),
    };
  }
}

extension UserEntityX on UserEntity {
  UserDTO toDto() {
    return UserDTO(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      createdAt: createdAt,
    );
  }
}
