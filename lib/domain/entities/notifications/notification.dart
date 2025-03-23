import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

class NotificationEntity {
  final String message;
  final String id;
  final AdressesEntity adresse;

  NotificationEntity({
    required this.id,
    required this.message,
    required this.adresse,
  });

  // Convertir JSON en objet Dart
  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['notification_id'] as String,
      message: json['message'] != null ? json['message'] as String : '',
      adresse: AdressesEntity.fromJson2(json['data'] as Map<String, dynamic>),
    );
  }
}