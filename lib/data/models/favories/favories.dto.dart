// ignore_for_file: non_constant_identifier_names

class FavoriesDTO {
  final String user_id;
  final String address_id;

  FavoriesDTO({
    required this.user_id,
    required this.address_id,
  });

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'address_id': address_id,
    };
  }
}
