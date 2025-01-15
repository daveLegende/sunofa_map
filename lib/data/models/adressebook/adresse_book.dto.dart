// ignore_for_file: non_constant_identifier_names

import 'package:sunofa_map/domain/entities/created_at.dart';

class AdresseBookDTO {
  final String? id;
  final String personName;
  final String addressLabel;
  final String apartmentSuiteNote;
  final bool hasGoogleAddress;
  final String googleAddress;
  final CreatedAt createdAt;
  final int user_id;

  AdresseBookDTO({
    this.id,
    required this.personName,
    required this.addressLabel,
    required this.apartmentSuiteNote,
    required this.hasGoogleAddress,
    required this.googleAddress,
    required this.createdAt,
    required this.user_id,
  });

  // Convertir JSON en objet Dart
  factory AdresseBookDTO.fromJson(Map<String, dynamic> json) {
    return AdresseBookDTO(
      id: json['id'] as String,
      personName: json['personName'] as String,
      addressLabel: json['addressLabel'] as String,
      apartmentSuiteNote: json['apartmentSuiteNote'] as String,
      hasGoogleAddress: json['hasGoogleAddress'] == 1,
      googleAddress: json['googleAddress'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      user_id: json['user_id'] as int,
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
      // 'createdAt': createdAt.toJson(),
      'user_id': user_id,
    };
  }


  Map<String, dynamic> toJsonWithId() {
    return {
      "id": id,
      'personName': personName,
      'addressLabel': addressLabel,
      'apartmentSuiteNote': apartmentSuiteNote,
      'hasGoogleAddress': hasGoogleAddress ? 1 : 0,
      'googleAddress': googleAddress,
      // 'createdAt': createdAt.toJson(),
      'user_id': user_id,
    };
  }
}
