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
}