// import 'dart:convert';

// import 'package:sunofa_map/domain/entities/created_at.dart';
// import 'package:sunofa_map/domain/entities/user/user_entity.dart';

// class AdresseBookEntity {
//   final String? id;
//   final String personName;
//   final String addressLabel;
//   final String apartmentSuiteNote;
//   final bool hasGoogleAddress;
//   final String googleAddress;
//   final CreatedAt? createdAt;
//   final UserEntity? user;

//   AdresseBookEntity({
//     this.id,
//     required this.personName,
//     required this.addressLabel,
//     required this.apartmentSuiteNote,
//     required this.hasGoogleAddress,
//     required this.googleAddress,
//     this.createdAt,
//     required this.user,
//   });

//   // Convertir JSON en objet Dart
//   factory AdresseBookEntity.fromJson(Map<String, dynamic> json) {
//     return AdresseBookEntity(
//       id: json['id'] as String,
//       personName: json['personName'] != null ? json['personName'] as String : '',
//       addressLabel: json['addressLabel'] != null ? json['addressLabel'] as String : '',
//       apartmentSuiteNote: json['apartmentSuiteNote'] != null ? json['apartmentSuiteNote'] as String : '',
//       hasGoogleAddress: json['hasGoogleAddress'] == 1,
//       googleAddress: json['googleAddress'] != null ? json['googleAddress'] as String : '',
//       user: json["user"] != null ? UserEntity.fromJson(json['user'] as Map<String, dynamic>) : null,
//       createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
//     );
//   }

//   // Convertir un objet Dart en JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'personName': personName,
//       'addressLabel': addressLabel,
//       'apartmentSuiteNote': apartmentSuiteNote,
//       'hasGoogleAddress': hasGoogleAddress ? 1 : 0,
//       'googleAddress': googleAddress,
//       'createdAt': createdAt!.toJson(),
//     };
//   }
// }

// // list des equipes
// List<AdresseBookEntity> adresseBookListFromJson(String jsonString) {
//   // Décoder la chaîne JSON en un objet Dart
//   final Map<String, dynamic> jsonData = json.decode(jsonString);

//   final List<dynamic> dataList = jsonData['data'];
//   return List<AdresseBookEntity>.from(
//     dataList.map(
//       (items) => AdresseBookEntity.fromJson(items),
//     ),
//   );
// }

import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

class AdresseBookEntity {
  final String? id;
  final String personName;
  final String addressLabel;
  final String apartmentSuiteNote;
  final bool hasGoogleAddress;
  final String googleAddress;
  final CreatedAt? createdAt;
  final UserEntity? user; // Rendu optionnel

  AdresseBookEntity({
    this.id,
    required this.personName,
    required this.addressLabel,
    required this.apartmentSuiteNote,
    required this.hasGoogleAddress,
    required this.googleAddress,
    this.createdAt,
    this.user, // Optionnel maintenant
  });

  // Convertir JSON en objet Dart
  factory AdresseBookEntity.fromJson(Map<String, dynamic> json) {
    return AdresseBookEntity(
      id: json['id'] as String?,
      personName: json['personName'] ?? '',
      addressLabel: json['addressLabel'] ?? '',
      apartmentSuiteNote: json['apartmentSuiteNote'] ?? '',
      hasGoogleAddress: json['hasGoogleAddress'] == 1,
      googleAddress: json['googleAddress'] ?? '',
      user: json["user"] != null ? UserEntity.fromJson(json['user'] as Map<String, dynamic>) : null,
      createdAt: json['createdAt'] != null ? CreatedAt.fromJson(json['createdAt']) : null,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personName': personName,
      'addressLabel': addressLabel,
      'apartmentSuiteNote': apartmentSuiteNote,
      'hasGoogleAddress': hasGoogleAddress ? 1 : 0,
      'googleAddress': googleAddress,
      'user': user?.toJson(), // Vérifie si `user` est null
      'createdAt': createdAt?.toJson(), // Vérifie si `createdAt` est null
    };
  }
}

// Liste des adresses
List<AdresseBookEntity> adresseBookListFromJson(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  
  if (jsonData['data'] == null) return [];

  final List<dynamic> dataList = jsonData['data'];
  return List<AdresseBookEntity>.from(
    dataList.map(
      (item) => AdresseBookEntity.fromJson(item as Map<String, dynamic>),
    ),
  );
}
