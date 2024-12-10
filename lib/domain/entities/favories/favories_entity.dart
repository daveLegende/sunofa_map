import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
class FavoriesEntity {
  final int? id;
  final CreatedAt createdAt;

  FavoriesEntity({
    this.id,
    required this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory FavoriesEntity.fromJson(Map<String, dynamic> json) {
    return FavoriesEntity(
      id: json['id'] as int,
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

// list des equipes
List<FavoriesEntity> betListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<FavoriesEntity>.from(
    data.map(
      (items) => FavoriesEntity.fromJson(items),
    ),
  );
}
