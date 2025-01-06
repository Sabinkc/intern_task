import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return openDatabase(dbLocation, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    
    await db.execute('''
    CREATE TABLE favorites (
      id $idType,
      title $textType,
      authors $textType,
      imageUrl $textType
    )
    ''');
  }

  Future<void> insertFavorite(Map<String, dynamic> book) async {
    final db = await instance.database;
    await db.insert('favorites', {
      'title': book['title'],
      'authors': json.encode(book['authors']),
      'imageUrl': book['imageLinks']?['thumbnail'] ?? '',
    });
  }

  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result;
  }

  Future<void> deleteFavorite(String title) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'title = ?', whereArgs: [title]);
  }
}
