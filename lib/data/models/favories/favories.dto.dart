import 'package:sunofa_map/domain/entities/created_at.dart';
class FavoriesDTO {
  final String? id;
  final CreatedAt createdAt;

  FavoriesDTO({
    this.id,
    required this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory FavoriesDTO.fromJson(Map<String, dynamic> json) {
    return FavoriesDTO(
      id: json['id'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toJson(),
    };
  }
}
