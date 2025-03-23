

// ignore_for_file: non_constant_identifier_names

class AdresseBookDTO {
  final String? id;
  final String personName;
  final String addressLabel;
  final String apartmentSuiteNote;
  final bool hasGoogleAddress;
  final String googleAddress;
  final String user_id;

  AdresseBookDTO({
    this.id,
    required this.personName,
    required this.addressLabel,
    required this.apartmentSuiteNote,
    required this.hasGoogleAddress,
    required this.googleAddress,
    required this.user_id,
  });

  // Convertir JSON en objet Dart
  factory AdresseBookDTO.fromJson(Map<String, dynamic> json) {
    return AdresseBookDTO(
      id: json['id'] as String,
      personName: json['person_name'] as String,
      addressLabel: json['address_label'] as String,
      apartmentSuiteNote: json['apartment_suite_note'] as String,
      hasGoogleAddress: json['has_google_address'] == 1,
      googleAddress: json['google_address'] as String,
      user_id: json['user_id'] as String,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'person_name': personName,
      'address_label': addressLabel,
      'apartment_suite_note': apartmentSuiteNote,
      'has_google_address': hasGoogleAddress ? true : false,
      'google_address': googleAddress,
      // 'createdAt': createdAt.toJson(),
      'user_id': user_id,
    };
  }


  Map<String, dynamic> toJsonWithId() {
    return {
      'person_name': personName,
      'address_label': addressLabel,
      'apartment_suite_note': apartmentSuiteNote,
      'has_google_address': hasGoogleAddress ? true : false,
      'google_address': googleAddress,
      // 'createdAt': createdAt.toJson(),
      'user_id': user_id,
    };
  }
}
