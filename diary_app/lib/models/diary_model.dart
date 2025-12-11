// lib/models/diary_model.dart
class DiaryEntry {
  final int? id;
  final String date;        // yyyy-MM-dd
  final String title;
  final String content;
  final String mood;        // NEW: e.g., "happy", "sad", "excited"

  DiaryEntry({
    this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.mood,     // now required
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'mood': mood,
    };
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      mood: map['mood'] ?? 'neutral',
    );
  }
}