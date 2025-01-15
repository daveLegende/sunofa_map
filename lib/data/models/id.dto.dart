class IdParms {
  final String id;

  const IdParms({required this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}
