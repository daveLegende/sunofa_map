
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/created_at.dart';

class UserEntity {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final CreatedAt createdAt;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.createdAt,
  });

  // Méthode pour convertir un JSON en objet User
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  // Méthode pour convertir un objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'createdAt': createdAt.toJson(),
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


