import 'dart:convert';


class FavoriesEntity {
  final String adresseId;
  final String userId;

  FavoriesEntity({
    required this.adresseId,
    required this.userId,
  });

  // Convertir JSON en objet Dart
  factory FavoriesEntity.fromJson(Map<String, dynamic> json) {
    return FavoriesEntity(
      adresseId: json['address_id'] as String,
      userId: json['user_id'] as String,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'address_id': adresseId,
      'user_id': userId,
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


List<FavoriesEntity> favListJson(String jsonString) {
  // Décoder la chaîne JSON en un objet Dart
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  // Extraire la liste des éléments de la clé "data"
  final List<dynamic> dataList = jsonData['data'];

  // Transformer chaque élément en un objet AdressesEntity
  return dataList.map((item) => FavoriesEntity.fromJson(item)).toList();
}