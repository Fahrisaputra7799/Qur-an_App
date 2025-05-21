class Ayah {
  final int numberInSurah;
  final String text;

  Ayah({
    required this.numberInSurah,
    required this.text,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      numberInSurah: json['numberInSurah'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
