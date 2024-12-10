import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
class AdresseBookEntity {
  final int? id;
  final String personName;
  final String addressLabel;
  final String apartmentSuiteNote;
  final bool hasGoogleAddress;
  final String googleAddress;
  final CreatedAt createdAt;

  AdresseBookEntity({
    this.id,
    required this.personName,
    required this.addressLabel,
    required this.apartmentSuiteNote,
    required this.hasGoogleAddress,
    required this.googleAddress,
    required this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory AdresseBookEntity.fromJson(Map<String, dynamic> json) {
    return AdresseBookEntity(
      id: json['id'] as int,
      personName: json['personName'] as String,
      addressLabel: json['addressLabel'] as String,
      apartmentSuiteNote: json['apartmentSuiteNote'] as String,
      hasGoogleAddress: json['hasGoogleAddress'] == 1,
      googleAddress: json['googleAddress'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'personName': personName,
      'addressLabel': addressLabel,
      'apartmentSuiteNote': apartmentSuiteNote,
      'hasGoogleAddress': hasGoogleAddress ? 1 : 0,
      'googleAddress': googleAddress,
      'createdAt': createdAt.toJson(),
    };
  }
}

// list des equipes
List<AdresseBookEntity> betListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<AdresseBookEntity>.from(
    data.map(
      (items) => AdresseBookEntity.fromJson(items),
    ),
  );
}
