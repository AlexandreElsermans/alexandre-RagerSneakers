import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DAO {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('hitorique_achat.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path, version: 2,
      onCreate: _createDB
    );
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE historique_achat (
        id_histo_achat INTEGER PRIMARY KEY AUTOINCREMENT,
        article_id INTEGER NOT NULL,
        title VARCHAR(255) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        description VARCHAR(1056) NOT NULL,
        img VARCHAR(1056) NOT NULL,
        user_id TEXT NOT NULL
      )
    ''');
  }
}