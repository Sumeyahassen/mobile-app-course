// lib/models/diary_model.dart
class DiaryEntry {
  final int? id;
  final String date;        // format: 2025-12-05
  final String title;
  final String content;

  DiaryEntry({
    this.id,
    required this.date,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
    };
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      content: map['content'],
    );
  }
}