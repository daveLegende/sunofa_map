// // ignore_for_file: non_constant_identifier_names

// import 'package:sunofa_map/domain/entities/created_at.dart';
// import 'package:sunofa_map/domain/entities/medias/media_entity.dart';

// class AdresseDTO {
//   final String? id;
//   final String pseudo;
//   final String adressName;
//   final String? googleAddress;
//   final String city;
//   final String? info;
//   final double? longitude;
//   final double? latitude;
//   final dynamic codePin;
//   final bool favory;
//   final CreatedAt? createdAt;
//   final String user_id;
//   final MediaEntity? media;

//   AdresseDTO({
//     this.id,
//     required this.pseudo,
//     required this.adressName,
//     required this.city,
//     this.googleAddress,
//     this.info,
//     this.longitude,
//     this.latitude,
//     this.codePin,
//     this.favory = false,
//     required this.user_id,
//     this.createdAt,
//     this.media,
//   });

//   // Convertir JSON en objet Dart
//   factory AdresseDTO.fromJson(Map<String, dynamic> json) {
//     return AdresseDTO(
//       id: json['id'] as String,
//       pseudo: json['pseudo'] as String,
//       adressName: json['adressName'] as String,
//       city: json['city'] as String,
//       info: json['info'] as String,
//       longitude: double.parse(json['longitude']),
//       latitude: double.parse(json['latitude']),
//       codePin: json['codePin'],
//       favory: json['favory'] as bool,
//       createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
//       user_id: json['user_id'] as String,
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
//       'user_id': user_id,
//       'media': media!.toJson(),
//       // 'createdAt': createdAt!.toJson(),
//     };
//   }

//   // Convertir un objet Dart en JSON
//   Map<String, dynamic> toJsonWithId() {
//     return {
//       "id": id!.toString(),
//       'pseudo': pseudo.toString(),
//       'adressName': adressName,
//       'city': city.toString(),
//       'info': info.toString(),
//       'user_id': user_id,
//       // 'createdAt': createdAt!.toJson(),
//     };
//   }
// }

// ignore_for_file: non_constant_identifier_names

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/medias/media_entity.dart';

class AdresseDTO {
  final String? id;
  final String pseudo;
  final String adressName;
  final String? googleAddress;
  final String city;
  final String? info;
  final double? longitude;
  final double? latitude;
  final int? codePin; // ✅ Change to int?
  final bool favory;
  final CreatedAt? createdAt;
  final String user_id;
  final MediaEntity? media;

  AdresseDTO({
    this.id,
    required this.pseudo,
    required this.adressName,
    required this.city,
    this.googleAddress,
    this.info,
    this.longitude,
    this.latitude,
    this.codePin, // ✅ Now int?
    this.favory = false,
    required this.user_id,
    this.createdAt,
    this.media,
  });

  // Convertir JSON en objet Dart
  factory AdresseDTO.fromJson(Map<String, dynamic> json) {
    return AdresseDTO(
      id: json['id'] as String?,
      pseudo: json['pseudo'] as String,
      adressName: json['adressName'] as String,
      city: json['city'] as String,
      info: json['info'] as String?,
      googleAddress: json['googleAddress'] as String?,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      codePin: json['codePin'] != null
          ? int.tryParse(json['codePin'].toString())
          : null, // ✅ Parse as int
      favory: json['favory'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>)
          : null,
      user_id: json['user_id'] as String,
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
      if (info != null) 'info': info,
      if (googleAddress != null) 'googleAddress': googleAddress,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (codePin != null) 'codePin': codePin, // ✅ Only include if not null
      'favory': favory,
      'user_id': user_id,
      if (media!.photo1 != null) 'photo1': media!.photo1,
      if (media!.photo2 != null) 'photo2': media!.photo2,
      if (media!.video1 != null) 'video1': media!.video1,
      if (media!.video2 != null) 'video2': media!.video2,
    };
  }

  // Convertir un objet Dart en JSON avec l'ID
  Map<String, dynamic> toJsonWithId() {
    return {
      'pseudo': pseudo,
      'adressName': adressName,
      'city': city,
      if (info != null) 'info': info,
      if (googleAddress != null) 'googleAddress': googleAddress,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (codePin != null && codePin.toString().isNotEmpty) 'codePin': codePin.toString(), // ✅ Only include if not null
      'favory': favory,
      'user_id': user_id,
      if (media != null) 'media': media!.toJson(),
    };
  }
}
