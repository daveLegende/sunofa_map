import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/medias/media_entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

class AdressesEntity {
  final String? id;
  final String pseudo;
  final String adressName;
  final String city;
  final String info;
  final double longitude;
  final double latitude;
  final dynamic codePin;
  // final String? googleAddress;
  final bool isFavorited;
  final CreatedAt createdAt;
  final UserEntity user;
  final MediaEntity? media;

  AdressesEntity({
    this.id,
    required this.pseudo,
    required this.adressName,
    required this.city,
    required this.info,
    required this.longitude,
    required this.latitude,
    required this.codePin,
    // required this.googleAddress,
    required this.isFavorited,
    required this.user,
    required this.createdAt,
    this.media,
  });

  // Convertir JSON en objet Dart
  factory AdressesEntity.fromJson(Map<String, dynamic> json) {
    return AdressesEntity(
      id: json['id'] as String,
      pseudo: json['pseudo'] as String,
      adressName: json['adressName'] as String,
      city: json['city'] as String,
      info: json['info'] as String,
      // googleAddress: json['googleAddress'] as String,
      longitude: double.parse(json['longitude']),
      latitude: double.parse(json['latitude']),
      codePin: json['codePin'],
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      isFavorited: json['isFavorited'] as bool,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      media: json['media'] != null
          ? MediaEntity.fromJson(json['media'] as Map<String, dynamic>)
          : null,
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
      'createdAt': createdAt.toJson(),
      'media': media!.toJson(),
    };
  }
}

// list des arbitres
List<AdressesEntity> adressesListJson(String jsonString) {
  // Décoder la chaîne JSON en un objet Dart
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  // Extraire la liste des éléments de la clé "data"
  final List<dynamic> dataList = jsonData['data'];

  // Transformer chaque élément en un objet AdressesEntity
  return dataList.map((item) => AdressesEntity.fromJson(item)).toList();
}
