import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

class NotificationDTO {
  final String message;
  final String id;
  final AdressesEntity adresse;

  NotificationDTO({
    required this.id,
    required this.message,
    required this.adresse,
  });

  // Convertir JSON en objet Dart
  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['notification_id'] as String,
      message: json['message'] != null ? json['message'] as String : '',
      adresse: AdressesEntity.fromJson2(json['data'] as Map<String, dynamic>),
    );
  }
}