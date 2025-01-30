// import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

class UserDTO {
  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final CreatedAt? createdAt;

  UserDTO({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.createdAt,
  });

  // Méthode pour convertir un JSON en objet User
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] as String,
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
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }

  Map<String, dynamic> toRegisterJson() {
    return {
      // "id": id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}

extension UserDTOX on UserDTO {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      createdAt: createdAt!,
    );
  }
}



