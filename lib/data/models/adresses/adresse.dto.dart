// ignore_for_file: non_constant_identifier_names

import 'package:sunofa_map/domain/entities/created_at.dart';

class AdresseDTO {
  final String? id;
  final String pseudo;
  final String adressName;
  final String? googleAddress;
  final String city;
  final String? info;
  final double? longitude;
  final double? latitude;
  final dynamic codePin;
  final bool isFavorited;
  final CreatedAt? createdAt;
  final String user_id;

  AdresseDTO({
    this.id,
    required this.pseudo,
    required this.adressName,
    required this.city,
    this.googleAddress,
    this.info,
    this.longitude,
    this.latitude,
    this.codePin,
    this.isFavorited = false,
    required this.user_id,
    this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory AdresseDTO.fromJson(Map<String, dynamic> json) {
    return AdresseDTO(
      id: json['id'] as String,
      pseudo: json['pseudo'] as String,
      adressName: json['adressName'] as String,
      city: json['city'] as String,
      info: json['info'] as String,
      longitude: double.parse(json['longitude']),
      latitude: double.parse(json['latitude']),
      codePin: json['codePin'],
      isFavorited: json['isFavorited'] as bool,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      user_id: json['user_id'] as String,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'pseudo': pseudo,
      'adressName': adressName,
      'city': city,
      'info': info,
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
      'codePin': codePin,
      'isFavorited': isFavorited,
      'user_id': user_id,
      // 'createdAt': createdAt!.toJson(),
    };
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJsonWithId() {
    return {
      "id": id!.toString(),
      'pseudo': pseudo.toString(),
      'adressName': adressName,
      'city': city.toString(),
      'info': info.toString(),
      'user_id': user_id,
      // 'createdAt': createdAt!.toJson(),
    };
  }
}
