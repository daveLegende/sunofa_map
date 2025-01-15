import 'dart:convert';

import 'package:sunofa_map/domain/entities/created_at.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

class NoteEntity {
  final String? id;
  final String title;
  final String contenu;
  final CreatedAt? createdAt;
  final UserEntity user;

  NoteEntity({
    this.id,
    required this.title,
    required this.contenu,
    this.createdAt,
    required this.user,
  });

  // Convertir JSON en objet Dart
  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json['id'] as String,
      title: json['title'] != null ? json['title'] as String : '',
      contenu: json['contenu'] != null ? json['contenu'] as String : '',
      createdAt: CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'contenu': contenu,
      // 'createdAt': createdAt!.toJson(),
    };
  }
}

// list des notes
List<NoteEntity> noteListJson(String jsonString) {
  // Décoder la chaîne JSON en un objet Dart
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  // Extraire la liste des éléments de la clé "data"
  final List<dynamic> dataList = jsonData['data'];

  // Transformer chaque élément en un objet AdressesEntity
  return dataList.map((item) => NoteEntity.fromJson(item)).toList();
}
