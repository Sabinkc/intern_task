import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

/// This class handles database operations for storing favorite books.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter for the database instance, initializes it if not already done.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  // Initializes the database with the given path.
  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return openDatabase(dbLocation, version: 1, onCreate: _onCreate);
  }

  // Creates the 'favorites' table if it doesn't exist already.
  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE favorites (
      id $idType,                // Auto-incremented primary key.
      title $textType,           // Book title.
      authors $textType,         // JSON-encoded list of authors.
      imageUrl $textType         // URL for the book's image.
    )
    '''); // SQL query to create the table.
  }

  /// Inserts a book into the 'favorites' table.

  Future<void> insertFavorite(Map<String, dynamic> book) async {
    final db = await instance.database;
    await db.insert('favorites', {
      'title': book['title'],
      'authors': json.encode(book['authors']),
      'imageUrl': book['imageLinks']?['thumbnail'] ?? '',
    });
  }

  /// Fetches all books from the 'favorites' table.

  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result;
  }

  /// Deletes a book from the 'favorites' table based on its title.

  Future<void> deleteFavorite(String title) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'title = ?', whereArgs: [title]);
  }
}
