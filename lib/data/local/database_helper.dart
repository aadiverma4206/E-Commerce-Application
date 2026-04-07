import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'favorite_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        title TEXT,
        image TEXT,
        price REAL
      )
    ''');
  }

  Future<void> insertFavorite(FavoriteModel fav) async {
    final db = await instance.database;
    await db.insert('favorites', fav.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavoriteModel>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');

    return result.map((e) => FavoriteModel.fromMap(e)).toList();
  }

  Future<void> deleteFavorite(String id) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}