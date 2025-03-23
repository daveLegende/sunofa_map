class IdParms {
  final String id;

  const IdParms({required this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}

class FullPin {
  final String id;
  final int fullPin;

  const FullPin({
    required this.id,
    required this.fullPin,
  });

  Map<String, dynamic> toJson() {
    return {
      // "id": id,
      "full_pin": fullPin,
    };
  }
}
