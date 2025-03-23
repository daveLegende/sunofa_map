class CreatedAt {
  final String datetime;
  final String humanDiff;
  final String human;

  CreatedAt({
    required this.datetime,
    required this.humanDiff,
    required this.human,
  });

  // Méthode pour convertir un JSON en objet CreatedAt
  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      datetime: json['datetime'] as String,
      humanDiff: json['humanDiff'] as String,
      human: json['human'] as String,
    );
  }

  // Méthode pour convertir un objet CreatedAt en JSON
  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'humanDiff': humanDiff,
      'human': human,
    };
  }

  // Fournir une instance par défaut
  factory CreatedAt.defaultValue() {
    return CreatedAt(
      datetime: DateTime.now().toIso8601String(),
      humanDiff: "Just now",
      human: "Now",
    );
  }

  DateTime get dateTimeObject {
    return DateTime.parse(datetime); // Convertit la chaîne en DateTime
  }
}

// Filtrer une liste d'objets en fonction de la date de création
List<CreatedAt> filterByDate(List<CreatedAt> items, DateTime filterDate) {
  return items.where((item) {
    // Comparer la date de création de chaque objet avec la date de filtrage
    return item.dateTimeObject.isAfter(filterDate);
  }).toList();
}