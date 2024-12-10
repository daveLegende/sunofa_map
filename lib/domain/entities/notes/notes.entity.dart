import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';

class NoteEntity {
  final int? id;
  final String title;
  final String contenu;
  final CreatedAt createdAt;

  NoteEntity({
    this.id,
    required this.title,
    required this.contenu,
    required this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      contenu: json['contenu'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'contenu': contenu,
      'createdAt': createdAt.toJson(),
    };
  }
}


// list des equipes
List<NoteEntity> betListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<NoteEntity>.from(
    data.map(
      (items) => NoteEntity.fromJson(items),
    ),
  );
}
