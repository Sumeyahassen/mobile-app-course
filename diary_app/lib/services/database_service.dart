// lib/services/database_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/diary_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._();

  DatabaseService._();

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'diary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL,
            title TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertEntry(DiaryEntry entry) async {
    final db = await database;
    return await db.insert('entries', entry.toMap());
  }

  Future<List<DiaryEntry>> getAllEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('entries', orderBy: 'date DESC');

    return List.generate(maps.length, (i) => DiaryEntry.fromMap(maps[i]));
  }

  Future<int> updateEntry(DiaryEntry entry) async {
    final db = await database;
    return await db.update('entries', entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> deleteEntry(int id) async {
    final db = await database;
    await db.delete('entries', where: 'id = ?', whereArgs: [id]);
  }
}