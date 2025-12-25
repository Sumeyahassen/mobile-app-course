class Nasheed {
  final int id;
  final String title;
  final String artist;
  final String language;
  final String file;

  Nasheed({
    required this.id,
    required this.title,
    required this.artist,
    required this.language,
    required this.file,
  });

  factory Nasheed.fromJson(Map<String, dynamic> json) {
    return Nasheed(
      id: json['id'],
      title: json['title'],
      artist: json['artist'] ?? 'Unknown',
      language: json['language'],
      file: json['file'],
    );
  }
}