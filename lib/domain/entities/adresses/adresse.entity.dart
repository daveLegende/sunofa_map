import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/medias/media_entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

// class AdressesEntity {
//   final String? id;
//   final String pseudo;
//   final String adressName;
//   final String city;
//   final String info;
//   final double? longitude;
//   final double? latitude;
//   final dynamic codePin;
//   final String? googleAddress;
//   final bool favory;
//   final CreatedAt createdAt;
//   final UserEntity user;
//   final MediaEntity? media;

//   AdressesEntity({
//     this.id,
//     required this.pseudo,
//     required this.adressName,
//     required this.city,
//     required this.info,
//     required this.longitude,
//     required this.latitude,
//     required this.codePin,
//     this.googleAddress,
//     required this.favory,
//     required this.user,
//     required this.createdAt,
//     this.media,
//   });

//   // Convertir JSON en objet Dart
//   // factory AdressesEntity.fromJson(Map<String, dynamic> json) {
//   //   return AdressesEntity(
//   //     id: json['id'] as String,
//   //     pseudo: json['pseudo'] as String,
//   //     adressName: json['adressName'] as String,
//   //     city: json['city'] as String,
//   //     info: json['info'] as String,
//   //     // googleAddress: json['googleAddress'] as String,
//   //     longitude: double.parse(json['longitude']),
//   //     latitude: double.parse(json['latitude']),
//   //     codePin: json['codePin'],
//   //     user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
//   //     favory: json['favory'] as bool,
//   //     createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
//   //     media: json['media'] != null
//   //         ? MediaEntity.fromJson(json['media'] as Map<String, dynamic>)
//   //         : null,
//   //   );
//   // }

//   factory AdressesEntity.fromJson(Map<String, dynamic> json) {
//     return AdressesEntity(
//       id: json['id'] as String?,
//       pseudo: json['pseudo'] as String,
//       adressName: json['adressName'] as String,
//       googleAddress: json['googleAddress'] as String,
//       city: json['city'] as String,
//       info: json['info'] as String,
//       longitude: json['longitude'].toDouble(),
//       latitude: json['latitude'].toDouble(),
//       codePin: json['codePin'],
//       user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
//       favory: json['favory'] as bool,
//       createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
//       media: json['media'] != null
//           ? MediaEntity.fromJson(json['media'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   // Convertir un objet Dart en JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'pseudo': pseudo,
//       'adressName': adressName,
//       'city': city,
//       'info': info,
//       'longitude': longitude.toString(),
//       'latitude': latitude.toString(),
//       'codePin': codePin,
//       'favory': favory,
//       'createdAt': createdAt.toJson(),
//       'media': media!.toJson(),
//     };
//   }
// }

class AdressesEntity {
  final String? id;
  final String pseudo;
  final String adressName;
  final String city;
  final String info;
  final double? longitude;
  final double? latitude;
  final int? codePin;
  final String? googleAddress; // Ajout du "?" pour rendre optionnel
  final bool favory;
  final CreatedAt? createdAt;
  final String? createdNotifAt;
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
    this.googleAddress, // Plus besoin de required
    required this.favory,
    required this.user,
    this.createdAt,
    this.createdNotifAt,
    this.media,
  });

  // Convertir JSON en objet Dart
  factory AdressesEntity.fromJson(Map<String, dynamic> json) {
    return AdressesEntity(
      id: json['id'] as String?,
      pseudo: json['pseudo'] as String,
      adressName: json['adressName'] as String,
      googleAddress: json['googleAddress'] as String?,
      city: json['city'] as String,
      info: json['info'] as String,
      longitude:
          json['longitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      codePin: json['codePin'],
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      favory: json['favory'] == 1,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      media: json['media'] != null
          ? MediaEntity.fromJson(json['media'] as Map<String, dynamic>)
          : null,
    );
  }

  factory AdressesEntity.fromJson2(Map<String, dynamic> json) {
    return AdressesEntity(
      id: json['id'] as String?,
      pseudo: json['pseudo'] as String,
      adressName: json['adressName'] as String,
      googleAddress: json['googleAddress'] as String?,
      city: json['city'] as String,
      info: json['info'] as String,
      longitude: json['longitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      codePin: json['codePin'],
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      favory: json['favory'] == 1,
      createdNotifAt: json['created_at'] as String,
      media: json['media'] != null
          ? MediaEntity.fromJson(json['media'] as Map<String, dynamic>)
          : null,
    );
  }

  // Méthode copyWith
  AdressesEntity copyWith({
    String? id,
    String? pseudo,
    String? adressName,
    String? city,
    String? info,
    double? longitude,
    double? latitude,
    int? codePin,
    String? googleAddress,
    bool? favory,
    CreatedAt? createdAt,
    UserEntity? user,
    MediaEntity? media,
  }) {
    return AdressesEntity(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      adressName: adressName ?? this.adressName,
      city: city ?? this.city,
      info: info ?? this.info,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      codePin: codePin ?? this.codePin,
      googleAddress: googleAddress ?? this.googleAddress,
      favory: favory ?? this.favory,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      media: media ?? this.media,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'pseudo': pseudo,
      'adressName': adressName,
      'city': city,
      'info': info,
      'longitude': longitude,
      'latitude': latitude,
      'codePin': codePin,
      'googleAddress':
          (googleAddress != null && googleAddress!.trim().isNotEmpty)
              ? googleAddress
              : null,
      'favory': favory,
      'createdAt': createdAt?.toJson(),
      'media': media?.toJson(), // Vérifier null
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
