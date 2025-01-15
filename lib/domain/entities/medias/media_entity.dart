class MediaEntity {
  final String? id;
  final String? photo1;
  final String? photo2;
  final String? audio1;
  final String? audio2;
  final String? video1;
  final String? video2;

  MediaEntity({
    this.id,
    this.photo1,
    this.photo2,
    this.audio1,
    this.audio2,
    this.video1,
    this.video2,
  });

  // Convertir JSON en objet Dart
  factory MediaEntity.fromJson(Map<String, dynamic> json) {
    return MediaEntity(
      id: json['id'] != null ? json['id'] as String : null,
      photo1: json['photo1'] != null ? json['photo1'] as String : null,
      photo2: json['photo2'] != null ? json['photo2'] as String : null,
      audio1: json['audio1'] != null ? json['audio1'] as String : null,
      audio2: json['audio2'] != null ? json['audio2'] as String : null,
      video1: json['video1'] != null ? json['video1'] as String : null,
      video2: json['video2'] != null ? json['video2'] as String : null,
    );
  }

  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo1': photo1,
      'photo2': photo2,
      'audio1': audio1,
      'audio2': audio2,
      'video1': video1,
      'video2': video2,
    };
  }
}