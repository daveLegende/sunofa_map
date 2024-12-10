import 'package:sunofa_map/domain/entities/created_at.dart';

class NoteDTO {
  final String? id;
  final String title;
  final String contenu;
  final CreatedAt createdAt;

  NoteDTO({
    this.id,
    required this.title,
    required this.contenu,
    required this.createdAt,
  });

  // Convertir JSON en objet Dart
  factory NoteDTO.fromJson(Map<String, dynamic> json) {
    return NoteDTO(
      id: json['id'] as String,
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