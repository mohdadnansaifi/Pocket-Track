import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
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
  }
  static Future<void> clearDatabase() async {
    final db = await database;

    await db.delete('transactions'); // 👈 table name
  }
}