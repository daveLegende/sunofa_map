// ignore_for_file: non_constant_identifier_names

import 'package:sunofa_map/domain/entities/created_at.dart';

class NoteDTO {
  final String? id;
  final String title;
  final String contenu;
  final CreatedAt? createdAt;
  final String user_id;

  NoteDTO({
    this.id,
    required this.title,
    required this.contenu,
    this.createdAt,
    required this.user_id,
  });

  // Convertir JSON en objet Dart
  factory NoteDTO.fromJson(Map<String, dynamic> json) {
    return NoteDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      contenu: json['contenu'] as String,
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      user_id: json['user_id'] as String,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'contenu': contenu,
      'user_id': user_id,
      // 'createdAt': createdAt.toJson(),
    };
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJsonWithId() {
    return {
      "id": id!,
      'title': title,
      'contenu': contenu,
      'user_id': user_id,
      // 'createdAt': createdAt!.toJson(),
    };
  }
}