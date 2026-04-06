import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  static Future<Database> get database async {
    try {
      if (_database != null) return _database!;
      _database = await initDB();
      return _database!;
    } catch (e) {
      throw Exception("Database initialization failed: $e");
    }
  }

  static Future<Database> initDB() async {
    try {
      final path = join(await getDatabasesPath(), 'finance.db');

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE transactions(
              id TEXT PRIMARY KEY,
              amount REAL,
              type TEXT,
              category TEXT,
              date TEXT,
              note TEXT
            )
          ''');
        },
      );
    } catch (e) {
      throw Exception("DB creation error: $e");
    }
  }

  static Future<void> clearDatabase() async {
    try {
      final db = await database;
      await db.delete('transactions');
    } catch (e) {
      throw Exception("Failed to clear database: $e");
    }
  }
}